proc glob-r {{dir .} ext} {
    set res {}

    set sorted_list [lsort [glob -nocomplain -dir $dir *]]

    foreach file $sorted_list {

        if {[file type $file] == "directory"} {
            eval lappend res [glob-r $file $ext]
        } else {
        	if {[string first ".$ext" $file] > 0} then {
	            lappend res [string range $file 1 end]
        	}
        }
    }

    return $res
}

#
#	Get a map of templates with their content.
#
proc find-files {base_dir ext} {

	# get all html files relative to the basedir
	set cwd [pwd]
	cd $base_dir
	set files [glob-r "." $ext]
	cd $cwd

	return $files
}

#
#	Get a map of templates with their content.
#
proc find-templates {base_dir {ext "html"}} {

	# get all html files relative to the basedir
	set cwd [pwd]
	cd $base_dir
	set files [glob-r "." $ext]
	cd $cwd

	#
	#	Make a map
	#
	foreach file $files {

		# construct template identifier
		set file_id $file
		set file_id [string map {".$ext" ""} $file_id]
		set file_id [string map {"/" "."} $file_id]

		# get template content
		set tpl_f [open "$base_dir/$file" r]
		set content ""
		while {! [eof $tpl_f] } {
			append content [gets $tpl_f]
			append content "\n"
		}
		close $tpl_f

		set filemap($file_id) [j' $content]
	}

	return [array get filemap]

}