package com.activitieskarate.testrunner;

import com.intuit.karate.junit5.Karate;

public class ActivitiesTestRunner {
	@Karate.Test
	Karate testActvitiesAPI() {
		return Karate.run("GetMethodActivities","PostMethodActivities","PutMethodActivities","DeleteMethodActivities").relativeTo(getClass());
	}
}
