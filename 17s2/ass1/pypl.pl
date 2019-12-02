#!/usr/bin/perl -w

### Course: COMP9041
### Program: Python to Perl translator
### File name: pypl.pl
### Author: Frank Li(Changfeng LI)
### zID: z5137858
### last edited: 4/10/17 20:51
### finished part: subset3 - 4 done

# ------------------------- Use packages
use warnings;

# ------------------------- Global var
our $current_indent = 0;
our $last_indent = 0;
our @py_key_words_set = ("while", "for", "if", "elif", "else",
					"False", "None", "continue", "break",
					"and", "or", "is", "return", "not", "with",
				    "pass", "except", "try", "global", "yield",
				    "assert", "import", "raise", "in", "from",
				    "as", "del", "class","finally", "def",
				    "nonlocal", "lambda", "True");
our @pl_key_words_set = ("while", "for", "if", "elsif", "else",
					"False","True", "last", "next", "and", "or",
					"return", "not", "my", "our", "scalar","sub");
				    
our @variables = ();
our @all_non_scalar_var_set = ();
our @not_add_tag_var_set = ("STDIN","print");
our @operator_set = ("\\+\\+","\\-\\-","\\*\\*\\=","\\*\\*","\\/\\/\\=","\\/\\/",
					"\\%\\=","\\=\\=","\\!\\=","\\<\\>","\\>\\>","\\<\\<",
					"\\>\\=","\\<\\=","\\+\\=","\\-\\=","\\*\\=","\\/\\=",
					"\\&","\\^","\\~","\\+","\\-","\\*","\\/","\\%","\\=","\\!",
					"\\>","\\<");
our $format_var = "(\[a-zA-Z_\]\\w\*)";#simpliest variable regular form
our $first_time_indent_change_tag = 0;
our $indent_type = 1;#default indent type :\_ (other may be \t)

# ------------------------- Declaration
sub line_scanner_operator($);

sub init($);
sub deal_head();
sub deal_comment($);
sub deal_blank_line($);
sub deal_import($);
sub deal_print($$);
sub deal_condition($$$$);
sub deal_for_in_loop($$$$$);
sub deal_single_line_procedure(@);
sub deal_expr($);
sub add_tag_to_expr;
sub handle_indent($$);
sub handle_each_line($$);

# ------------------------- Main program
no warnings 'uninitialized';
$operator_str = "(";

for $item (@operator_set) {
	$operator_str.="$item";
	if ($item ne $operator_set[-1]) {
		$operator_str.="\|";
	}

}
$operator_str.=")";
if (@ARGV) {

	$target_file = $ARGV[0];
	
	open my $f, '<', $target_file or die;
	open("RESULT", ">result.log");
	
	while (my $line = <$f>) {
	  	line_scanner_operator($line);
	}
	close $f;
}
else {
	open("RESULT", ">result.log");
	while ($line = <>) {
		line_scanner_operator($line);
	}
}
$d_idnt = ($last_indent)/$indent_type;
print RESULT "dint = $d_idnt\n";
print RESULT "末尾判断\n";
print RESULT "转换上一行缩进：$d_idnt\n";
print RESULT "转换当前行缩进：0\n";
if ($d_idnt > 0) {
	while ($d_idnt > 0) {
		print "\t" foreach (0+$d_idnt..0);
		print "}\n";
		$d_idnt--;
	}
}


# ------------------------- Function area
sub line_scanner_operator($) {
	my $l = $_[0];
	my $o = "";
	$sys_tag = 0;
	$line_num = $.;
	if ($line_num < 10) {
		$line_num =~ s/(.+)/0$1/;
	}
	$l= init($l);
	$l =~ m/^(\s*).*$/;
	$current_indent = length($1);
	print RESULT "$line_num ~~~~~~~~~~~~~~ 当前行 ==> \n$l\n";
	@a = handle_indent($last_indent,$current_indent);
	$o = $a[0];
	$current_fix_idnt = $a[1];
	print RESULT "####current _fix _indent = $current_fix_idnt\n";
	
	$o.= handle_each_line($l,$current_fix_idnt);
	# -- case0: Precompiler head obviously no indent
	$last_indent = $current_indent;
	print RESULT "$line_num ~~~~~~~~~~~~~~ 修正行 ==> \n$o";
	
	print "$o";
	print RESULT "--------------------------------------------------\n";
}

sub init($) {
	my $l_ = $_[0];
	$l_ =~ s/\n$//;
	return $l_;
}

# ---------------- deal by different line type(start with ???)
# Function: deal_head -->
# substitute python3 head to perl
sub deal_head() {
	my $info = "#!/usr/bin/perl -w\n";
	return $info;
}

# Function: deal_comment -->
# substitute line start with \s*#
sub deal_comment($) {
	my $info = "$_[0]\n";
	return $info;
}

# Function: deal_blank_line -->
# substitute ""
sub deal_blank_line($) {
	my $info = "\n";
	return $info;
}
# Function: deal_import -->
# filter line include "import ..."
# example: 
# import sys
sub deal_import($) {
	my $info = $_[0];
	$info =~ s/(^\s*import\s.+$)/\n/;
	return $info;
}

# Function: deal_print
# deal differnt case with print
sub deal_print($$) {
	my $content = $_[0];
	my $sys_tag = $_[1];
	print RESULT "当前内容：$content\n";
	if ($content =~ /^\s*$/) {
		print RESULT "当前模式：打印空\n";
		if ($sys_tag == 0) {
			$result = "print \"\\n\"\;\n";
		}
		else {
			$result = "print \"\"\;\n";
		}
	}
	# -- case2.1 content is {string} instance
	if ($content =~ /^(\'|\")(.*)(\'|\")$/) {
		print RESULT "当前模式：打印字符串\n";
		print RESULT "$1\n";
		print RESULT "$2\n";
		print RESULT "$3\n";
		if ($sys_tag == 0) {
			$result = "print $1$2\\n$3;\n";
		}
		else {
			$result = "print $1$2$3;\n";
		}
		
	}
	# -- case2.2 content is {var}
	elsif ($content =~ /^$format_var\s*$operator_str*.*/) {
		print RESULT "当前模式：打印表达式\n";
		$content = deal_expr($content);
		if ($sys_tag == 0) {
			$result = "print $content\,\"\\n\"\;\n";
		}
		else {
			$result = "print $content\,\"\"\;\n";
		}
		
			
	}

	elsif ($content =~ /^(\'|\")(.*)(\'|\")$/) {

	}
	print RESULT "jieguo = $result\n";
	return $result;
}

# Function: deal_condition
# deal differnt condition case : if elif else while...
sub deal_condition($$$$) {
	my $l_ = $_[0];
	my $pref = $_[1];
	my $cond = $_[2];
	my $proc = $_[3];
	my $o_ = "";
	print RESULT "行内容 ==> $l_\n";
	print RESULT "前缀 ==> $pref\n";
	print RESULT "条件 ==> $cond\n";
	print RESULT "执行单行语句体 ==> $proc\n";
	# judge indent
	my $indent_temp = $current_indent;
	
	# del redundant brackets
	if ($cond =~ m/^\(/) {
		$cond =~ s/^\(//g;
		$cond =~ s/\)$//g;
	}
	# tr prefix
	$pref = "elsif" if $pref eq "elif";
	$pref = "else {\n" if $pref eq "else";
	
	$o_.= "$pref";
	if ($pref ne "else {\n") {
		$o_.= " \(";
		$cond = deal_expr($cond);
		$o_.= "$cond\) {\n";
	}
	
	# case1: if condition: procedure ...
	# under this case: deal with block
	if ($proc ne "") {
		print RESULT "单行模式\n";
		$indent_temp++;
		@proc_list = split(/;/,$proc);
		push @proc_list, $indent_temp;
		$o_.= deal_single_line_procedure(@proc_list);
		
	}
	
	# case2: if condition: 
	#			procedure ...
	# under this case: deal line by line
	else {

		print RESULT "多行模式\n";
	}

	return "$o_\n";
}

# Function: deal_for_in_loop
# for i in range(...) ==> for $i (start..end-1) {
sub deal_for_in_loop($$$$$) {
	my $l_ = $_[0];
	my $pref = $_[1];
	my $item = $_[2];
	my $scle = $_[3];
	my $proc = $_[4];
	my $o_ = "";
	print RESULT "行内容 ==> $l_\n";
	print RESULT "前缀 ==> $pref\n";
	print RESULT "项目 ==> $item\n";
	print RESULT "循环范围 ==> $scle\n";
	print RESULT "执行单行语句体 ==> $proc\n";

	# judge indent
	my $indent_temp = $current_indent;
	# del redundant brackets
	if ($item =~ m/^\(/) {
		$item =~ s/^\(//g;
		$item =~ s/\)$//g;
	}
	$pref =~ s/for/foreach/;
	print RESULT "当前pref = $pref\n";
	$o_.= "$pref";
	print RESULT "当前o1 = $o_\n";
	$o_.= " ";
	$o_.= deal_expr($item);
	$o_.= " \(";
	print RESULT "当前o2 = $o_\n";
	$o_.= deal_expr($scle);
	$o_.= " \)";
	$o_.= " \{";
	print RESULT "当前o3 = $o_\n";
	# case1: for ...: procedure ...
	# under this case: deal with block
	if ($proc ne "") {
		print RESULT "单行模式\n";
		$indent_temp++;
		@proc_list = split(/;/,$proc);
		push @proc_list, $indent_temp;
		$o_.= deal_single_line_procedure(@proc_list);
		
	}
	
	# case2: for ...: 
	#			procedure ...
	# under this case: deal line by line
	else {

		print RESULT "多行模式\n";
	}
	return "$o_\n";
}

# Function: deal_single_line_procedure
# deal single line while|if|elsif|else|foreach
sub deal_single_line_procedure(@) {
	my @proc_list = @_;
	my $indent_t = $proc_list[-1];
	pop @proc_list;
	my $o_ = "";
	print RESULT "此单行含有子表达式的个数为：";
	print RESULT scalar @proc_list,"\n";
	print RESULT "procedure 列表 @proc_list\n";
	print RESULT "\n";
	foreach $expr (@proc_list) {
		$expr =~ s/^\s*//;
		$expr =~ s/\s*$//;
		$expr = handle_each_line($expr,$indent_t);
		$expr =~ s/;\n//;
		$o_.="\t" foreach (1..$indent_t);
		$o_.=$expr;
		$o_.=";\n";
		print RESULT ">>>>> \n";
		print RESULT "$o_";
	}

	$indent_t--;
	$o_.="\t" foreach (1..$indent_t);
	$o_.="}\n";
	print RESULT "----最终结果 => \n";
	print RESULT "$o_";
	
	return $o_;
}

# Function: deal_expr
# deal simle expr like $i++
# example: handle special such as int(a). sys...
sub deal_expr ($) {
	my $expr = $_[0];
	my @var = ();
	print RESULT "处理前0，表达式为：$expr\n";
	#$expr =~ s/$format_var/\ $1\ /g;
	print RESULT "处理后1，表达式为：$expr\n";
	#if ($expr =~ m/\"\s*$operator_str\s*\"/) {

	#}
	#else {
	#	$expr =~ s/$operator_str/\ $1\ /g;
	#}
	print RESULT "处理后2，表达式为：$expr\n";
	$expr =~ s/(\s)+/\ /g;
	$expr =~ s/^(\s)*//;
	$expr =~ s/(\s)*$//;
	print RESULT "处理后3，表达式为：$expr\n";

	$expr =~ s/\/\//\//g; # deal // --> /
	# ----------- simplify expr ---------
	#case1:tr break continue
	if ($expr =~ m/(break|next|pass)/) {
		$expr =~ s/break/last/;
		$expr =~ s/continue/next/;
		$expr =~ s/pass//;
		print RESULT "1111111111111\n";
		return $expr;
	}
	
	#case2:tr [] {}
	if ($expr =~ m/$format_var\s*$operator_str\s*(\[|\{)([^\[\]\{\}]*)(\]|\})/) {
		
		#print "---$expr\n";
		#$expr.= ";\n";
		print RESULT "1 ---> $1\n";
		print RESULT "2 ---> $2\n";
		print RESULT "类型 -> $3 -- $5\n";
		print RESULT "---content$4\n";
		if ($3 eq "[" and $5 eq "]") { # list
			print RESULT "novarset @all_non_scalar_var_set\n";
			print RESULT "2222222222222_0\n";
			push @all_non_scalar_var_set, $1;
			$expr =~ s/\[/\(/;
			$expr =~ s/\]/\)/;
		}
		elsif ($3 eq "{" and $5 eq "}") { #dict
			print RESULT "novarset @all_non_scalar_var_set\n";
			print RESULT "2222222222222_1\n";
		}
	}

	#case3:len()
	if ($expr =~ /len\(($format_var)/) {
		print RESULT "3333333333333\n";
		$expr =~ s/(\(|\{)//g;
		$expr =~ s/(\)|\})//g;
		$expr =~ s/(\@|\%)//g;
		$expr =~ s/len/\$\#/g;
		$expr =~ s/^(.+)$/$1+1/g;
	}

	#case4:range(a,b)
	if ($expr =~ m/range\s*\((.+),(.+)\)\s*/) {
		print RESULT "4444444444444\n";
		$start = $1;
		$end = $2;
		$expr =~ s/range\s*\((.+)\)/$1/;
		$expr =~ s/^(.+),(.+)$/$start..$end-1/;
	}
	#case5:range(a)
	if ($expr =~ /range\((.+)\)/) {
		print RESULT "5555555555555\n";
		$end = $1;
		$expr =~ s/range\s*\((.+)\)/$1/;
		$expr =~ s/$1/0..$end-1/g;
	}
	# case5:sys.stdout.write()
	if ($expr =~ m/sys\s*\.\s*stdout\s*\.\s*write\s*\(/) {
		print RESULT "6666666666666\n";
		$sys_tag = 1;
		$expr =~ s/\s*sys\s*\.\s*stdout\s*\.\s*write\s*\(/print /g;
		$expr =~ s/\)//g;
		print RESULT "$expr\n";
		$expr =~ m/^\s*print\s+(.+)$/;
		print RESULT "\$1 $1\n";
		if ($1 =~ /(\"|\')([^"']*)(\"|\')/) {
			print RESULT "--------\n";
			$detail_ = "$1$2$3";
		}
		else {
			print RESULT "++++++++\n";
			$detail_ = "\"";
			$detail_.= $1;
			$detail_.= "\"";
		}
		$expr = deal_print($detail_,$sys_tag);
		return $expr;
	}
	# case6 :sys.stdin.readlines()
	if ($expr =~ m/(sys\s*\.\s*stdin\s*\.\s*readlines?\s*\(\))/) {
		print RESULT "7777777777777\n";
		$expr =~ s/\s*sys\s*\.\s*stdin\s*\.\s*readlines\s*\(\)//;
    	$expr =~ s/\s*sys\s*\.\s*stdin\s*\.\s*readline\s*\(\)/<STDIN>/;
    	$expr =~ s/int\s*\(<STDIN>\)\s*/<STDIN>/;
    	@temp = $expr =~ m/($format_var)/g;
    	foreach $item (@temp) {
	    	if (grep {$_ eq $item} @not_add_tag_var_set) {
				next;
	    	}
	    	elsif (grep {$_ eq $item} @all_non_scalar_var_set) {
				next;
	    	}
	    	push @var, $item;
	    }

	}

	elsif ($expr =~ m/$format_var/) {
		@var = $expr =~ m/$format_var/g;
	}
	
	print RESULT "*@ var = @var\n";
	foreach $item (@var) {
		if (grep {$_ eq $item} @not_add_tag_var_set) {
			next;
	    }
	    elsif (grep {$_ eq $item} @all_non_scalar_var_set) {
			next;
	    }
	    else {
	    	push @variables,$item;
	    }
		
	}
	print RESULT "varia => @variables\n";
	print RESULT "nover => @all_non_scalar_var_set\n";
	add_tag_to_expr($expr);
	print RESULT "expr => $expr\n";
	return $expr;
}

# Function: add_tag_to_expr
# example: handle special such as int(a). sys...
# example: to add $@% to variable
sub add_tag_to_expr {
	foreach $arg (@_) {
	    foreach $var (@variables) {
			$arg =~ s/ $var/ \$$var/g;
			$arg =~ s/\t$var/\t\$$var/g;
			$arg =~ s/\($var/\(\$$var/g;
			$arg =~ s/\[$var/\[\$$var/g;
			$arg =~ s/\.$var/\.\$$var/g;
			$arg =~ s/\*$var/\*\$$var/g;
			$arg =~ s/^$var/\$$var/;
	    }
	    foreach $var (@all_non_scalar_var_set) {
	      	if ($arg =~ /$var\[/) {
		        $arg =~ s/ $var/ \$$var/g;
		        $arg =~ s/\t$var/\t\$$var/g;
		        $arg =~ s/\($var/\(\$$var/g;
		        $arg =~ s/\[$var/\[\$$var/g;
		        $arg =~ s/\.$var/\.\$$var/g;
		        $arg =~ s/\*$var/\*\$$var/g;
		        $arg =~ s/^$var/\$$var/;
	      	} 
	      	else {
		        $arg =~ s/ $var/ \@$var/g;
		        $arg =~ s/\t$var/\t\@$var/g;
		        $arg =~ s/\($var/\(\@$var/g;
		        $arg =~ s/\[$var/\[\@$var/g;
		        $arg =~ s/\.$var/\.\@$var/g;
		        $arg =~ s/^$var/\@$var/;
		    }
    	}
	}
}


# Function: handle_each_line
# example: by different case handle each line.
sub handle_each_line($$) {
	my $lin = $_[0];
	my $fix_indent = $_[1];
	my $out = "";
	if ($lin =~ /^\s*#!\/usr\/bin\/python3?\s*/) {
		$out.= deal_head();	
  	}

  	# -- case1: Precompiler head obviously no indent
  	elsif ($lin =~ /^\s*$/) {
  		$out.= deal_blank_line($lin);
  	}
  	# -- case2: comment obviously no indent
  	elsif ($lin =~ /^\s*\#^(import)*$/) {
  		$out.="\t" foreach (1..$current_fix_idnt);
  		$out.= deal_comment($lin);
  	}
  	# -- case3: python import obviously no indent
  	elsif ($lin =~ /^\s*import\s.+$/) {
  		$out.= deal_import($lin);
  	}

  	# -- case4: Print
	elsif ($lin =~ m/^\s*print\s*\((.*)\)\s*$/) {
		print RESULT "*******情况: 打印 ---> \n";
		$sys_tag = 0;
		$detail = $1;
		$out.="\t" foreach (1..$current_fix_idnt);
		$out.= deal_print($detail,$sys_tag);
	}

	# -- case5: single line assign value to variaiable
	elsif ($lin =~ /^\s*$format_var\s*$operator_str\s*.+\s*$/) {
		print RESULT "*******情况: 单行表达式 ---> \n";
		$out.="\t" foreach (1..$current_fix_idnt);
		$out.= deal_expr($lin).";"."\n";	
	}

	# -- case6: condition (if elif else)
	elsif ($lin =~ /^\s*(if|elif|else)\s*(.*):\s*(.*)\s*$/) {
		print RESULT "*******情况: 条件判断 ---> \n";
		$prefix = $1;
		$condition = $2;
		$single_line_procedure = $3;
		$out.="\t" foreach (1..$current_fix_idnt);
		$out.= deal_condition($lin,$prefix,$condition,$single_line_procedure);
	}

	# -- case7: while loop
	elsif ($lin =~ /^\s*(while)\s*(.+):\s*(.*)\s*$/) {
		print RESULT "********情况: while ---> \n";
		$prefix = $1;
		$condition = $2;
		$single_line_procedure = $3;
		$out.="\t" foreach (1..$current_fix_idnt);
		$out.= deal_condition($lin,$prefix,$condition,$single_line_procedure);
	}

	# -- case8: for _ in _ loop
	elsif ($lin =~ /^\s*(for)\s+(.+)\s+in\s+(.+)\s*:\s*(.*)\s*$/) {
		print RESULT "********情况: for in ---> \n";
		$prefix = $1;
		$item = $2;
		$scale = $3;
		$single_line_procedure = $4;
		$out.="\t" foreach (1..$current_fix_idnt);
		$out.= deal_for_in_loop($lin,$prefix,$item,$scale,$single_line_procedure);
	}

	# -- case9: sysout
	elsif ($lin =~ /^\s*(sys\.stdout\.write\()/) {
		print RESULT "******** 情况: sysout ---> \n";
		$out.="\t" foreach (1..$current_fix_idnt);
		$out.= deal_expr($lin);
	}
	

	# -- case10:break continue pass
	elsif ($lin =~ /^\s*(break|continue|pass)\s*/) {
		print RESULT "******** 情况: break|continue|pass ---> \n";
		$out.="\t" foreach (1..$current_fix_idnt);
		$out.= deal_expr($1);
		$out.= ";\n";
	}
	return $out;
}

# Function: handle_each_line
# example: by different case handle each line.
sub handle_indent($$) {
	my $o_ = "";
	$ori_l_indent = $_[0];
	$ori_c_indent = $_[1];
	
	print RESULT "原始上一行缩进：$ori_l_indent\n";
	print RESULT "原始当前行缩进：$ori_c_indent\n";
	
	$ori_delta_indent = $ori_l_indent - $ori_c_indent;
	if ($ori_delta_indent < 0) {
		if ($first_time_indent_change_tag == 0) {
			print RESULT "======\n";
			$first_time_indent_change_tag = 1;
			$indent_type = $ori_c_indent;
		}
	}
	
	$l_indent = $ori_l_indent/$indent_type;
	$c_indent = $ori_c_indent/$indent_type;
	print RESULT "转换上一行缩进：$l_indent\n";
	print RESULT "转换当前行缩进：$c_indent\n";
	$delta_indent = $l_indent - $c_indent;
	if ($delta_indent > 0) {
		print RESULT "delta indent：$delta_indent\n";

		while ($delta_indent > 0) {
			$o_.="\t" foreach (1..$c_indent);
			#$o_.=")";
			$o_.="\t" foreach (1..$delta_indent-1);
			$o_.="}\n";
			$delta_indent--;
		}
		
	}
	return ($o_,$c_indent);
}


