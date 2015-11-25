class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"/melanin",action:"login")
		
				"500"(view:'/errors/500')
				"401"(view:'/errors/403')
				"403"(view:'/errors/403')
				"404"(view:'/errors/404')
				
	}
}
