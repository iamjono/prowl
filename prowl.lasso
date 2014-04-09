[
// note, also requires string_truncate methods
// these can be removed from the file if already existing in the system.
define prowl => type {
	data 
		public apikey::string	   = string,
		public application::string  = 'add',
		
		private apihost = 'https://api.prowlapp.com/publicapi/'
 
	public onCreate() => {}
	public onCreate(apikey::string) => { .apikey = #apikey }
	
	private apicheck() => {
		return .apikey->size
	}

//	public retrieve(path::string,post::string='') => { 
//		fail_if(!.apicheck, -1, 'api key not set.')
//
//		protect => {
//			handle_error => {
//				local(response = 'There was a problem communicating with Prowl.')
//			}
//			local(getparams = array( 
//				'apikey='+.apikey, 
//				'application='+encode_url(.application), 
//				'event='+encode_url(#post) 
//			))
//			// note for future improvement: change to curl native to increase performance
//			local(response = include_url(.apihost + #path + '?' + #getparams->join('&')))
//		}
//		return #response->asString
//	}

	public update(-application::string,-event::string='',-description::string='',-priority::integer=0,-url::string='') => {
		fail_if(not .apicheck, -1, 'API key not set.')
		fail_if(#event->size == 0 && #description->size == 0, -2, 'An event or description, or both, must be supplied')
		protect => {
			handle_error => {
				return error_msg 
				//'There was a problem communicating with Prowl.'
			}
			local(postparams = array( 
				'apikey' = .apikey,
				'application' = #application
				)
			)
			#priority != 0 ? #postparams->insert('priority' = #priority) 
			#url->size ? #postparams->insert('url' = string_truncate(#url, 512)) 
			#event->size ? #postparams->insert('event' = string_truncate(#event, 1024)) 
			#description->size ? #postparams->insert('description' = string_truncate(#description, 10000))

			local(curl) = curl(.apihost+'add')
			#curl->set(CURLOPT_POSTFIELDS,
				(
					with param in #postParams
					select #param->first->asString->asBytes->encodeUrl + '=' + #param->second->asString->asBytes->encodeUrl
				)->join('&')
			)

			return #curl->asString
		}
	}
}
if(not lasso_tagexists('string_truncate')) => {
	// ==================================
	/*
		String_Truncate
		John Burwell
		
		String_Truncate takes three parameters: an input string, a -Length integer, and an optional -Ellipsis string. 
		It returns a string no longer than the specified -Length, appending the optional ellipsis if the string is actually truncated. 
		If the input string is shorter than the specified length, the full input string is returned and no ellipsis is appended. 
		Note: The length of the ellipsis is not counted when truncating the input string. The string is truncated to the specified length before the ellipsis is added.
		
		Parameters
			-String	string, required	The input string to be truncated
			-Length	integer, required	The maximum length of the output string
			-Ellipsis	string, optional	A string to append if the input is actually truncated
		Sample Usage
			[String_Truncate: $long_string, -Length=20, -Ellipsis='...'] 
	
		http://tagswap.net/String_Truncate/
	*/
	// ==================================
		
	define string_truncate(string::string,length::integer,ellipsis::string='...') => {
	  // Returns a string truncated to the specified -Length. An optional -Ellipsis parameter specifies a string to append if the string is actually truncated.
	
		if(#string->Size <= #length) => {
		    return #string
		else 
			return string_extract(#string, -StartPosition=1, -EndPosition=#length) + #ellipsis
		}
	}
	define string_truncate(string::string,-length::integer,-ellipsis::string='...') => {
	  return string_truncate(#string,#length,#ellipsis)
	}
}
]
