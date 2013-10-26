define prowl => type {
	data 
		public apikey::string	   = string,
		public application::string  = string
 
 
	private apicheck() => {
		return .apikey->size
	}
	  
	public retrieve(path::string,post::string='') => { 
		fail_if(!.apicheck, -1, 'api key not set.')
		  
		protect => {
			handle_error => {
				local(response = 'There was a problem communicating with Prowl.')
			}
			local(getparams = array( 
				'apikey='+.apikey, 
				'application='+encode_url(.application), 
				'event='+encode_url(#post) 
			))
			// note for future improvement: change to curl native to increase performance
			local(response = include_url('https://prowl.weks.net' + #path + '?' + #getparams->join('&')))
		}
		return #response->asString
	}
	  
	public update(event::string) => {
		local(path = '/publicapi/add') 
		return .retrieve(#path, string_truncate(#event, 1024))  
	}
}
