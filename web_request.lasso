<?lassoscript

define getparams => {
	var(_getparams) ? return $_getparams 
	return $_getparams := collateparams(web_request->queryparams)
}

define postparams => {
	var(_postparams) ? return $_postparams
	return $_postparams := collateparams(web_request->postparams)
}

define collateparams(params::staticarray) => {
	local(m = map,n,v,p) 
	#params->foreach => { 
		#p = #1
		#n = #p->first
		if(#n) => {
			#v = #m->find(#n)
			#v->isa(::array) 
			? #v->insert(#p->second)
			| #v = array(#p->second)
		}
		#m->insert(#n = #v)
	}
	return #m
}

define getparam(name::string) 	=> (getparams->find(#name) || staticarray)->join('\n') 
define postparam(name::string) 	=> (postparams->find(#name) || staticarray)->join('\n')

define getparam(name::string,i::integer) 	=> protect => {return getparams->find(#name)->get(#i)}
define postparam(name::string,i::integer) 	=> protect => {return postparams->find(#name)->get(#i)}

define getparam(name::string,-count) 	=> (getparams->find(#name) || staticarray)->size
define postparam(name::string,-count) 	=> (postparams->find(#name) || staticarray)->size

?>