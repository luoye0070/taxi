class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		//"/"(view:"/person/datagrid")
        "/"(controller:"easyuiLayout",action:"index")
		"500"(view:'/error')
	}
}
