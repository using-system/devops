variables {
        team        = "team-a"
        project     = "project-x"
        environment = "production"
        region      = "us-west-1"
        delimiter   = "-"
}

run "test_defaults" {
  assert {
    condition     = output.resource_name == "team-a-project-x-production-us-west-1"
    error_message = "Resource name is mal formatted"
  }
}