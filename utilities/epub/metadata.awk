/^[[:alpha:]]+: / {
	split($0, List, ": ")
	context=List[1]
	gsub(/^[[:alpha:]]+:[[:space:]]+/, "", $0)
	gsub(/[[:space:]]+$/, "", $0)
	Content[List[1]]=$0
}
/^[[:space:]]+/ {
	gsub(/^[[:space:]]+/, "", $0)
	gsub(/[[:space:]]+$/, "", $0)
	sep=" "
	if(context=="Tags" || context=="Category" || context=="Author")
		sep=", "

	Content[context] = ((Content[context]) (sep) ($0))
}
END {
	for (context in Content) {
		if(context=="Tags" || context=="Category" || context=="Author") {
			split(Content[context], Temp, ", ");
			for ( item in Temp ) {;
				print " -V "context"=\""Temp[item]"\"";
			};
		}else{
			print " -V "context"=\""Content[context]"\"";
		}
	}
}
