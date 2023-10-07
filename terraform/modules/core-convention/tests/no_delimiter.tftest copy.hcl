variables {
        team        = "team-a"
        project     = "project-x"
        environment = "production"
        region      = "us-west-1"
}

run "assertions" {
  assert {
    condition     = output.resource_name == "team-a-project-x-production-us-west-1"
    error_message = "Resource must contains delimiter"
  }

  assert {
    condition     = output.resource_name_without_delimiter == "team-aproject-xproductionus-west-1"
    error_message = "Resource must not contains delimiter"
  }
}