package com.authorskarate.testrunner;

import com.intuit.karate.junit5.Karate;

public class AuthorsTestRunner {
	@Karate.Test
	Karate testAuthorsAPI() {
		return Karate.run("PostMethodAuthors").relativeTo(getClass());
	}
}
