dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "msb"
    //dialect = org.hibernate.dialect.MySQL5InnoDBDialect
    properties {
        maxActive = 50
        maxIdle = 25
        minIdle = 1
        initialSize = 1
        numTestsPerEvictionRun = 3
        maxWait = 10000
        testOnBorrow = true
        testWhileIdle = true
        testOnReturn = true
        validationQuery = "select 1"
        minEvictableIdleTimeMillis = 1000 * 60 * 5
        timeBetweenEvictionRunsMillis = 1000 * 60 * 5
    }
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = "net.sf.ehcache.hibernate.EhCacheProvider"
}

// environment specific settings
environments {
    development {
		    dataSource {
			      dbCreate = "update" // one of 'create', 'create-drop','update'
//				  url = "jdbc:mysql://10.0.2.32:3306/oprisk3?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true"
//				  password = "10.0.2.32"
				  url = "jdbc:mysql://localhost:3306/oprisk3?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true"
				  user = "root"
				  password = "root"
		    }
	  }
	  test {
		    dataSource {
			      dbCreate = "update"
			      url = "jdbc:mysql://10.1.3.64:3306/oprisk_development4?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true"
		    }
	  }
	  production {
		    dataSource {
			      dbCreate = "update"
			      url = "jdbc:mysql://10.0.2.32:3306/oprisk3?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true"
				  password = "10.0.2.32"
		    }
	  }
}