variables {
        team        = "team1"
        project     = "projecta"
        environment = "prd"
        region      = "we"
        delimiter   = "_"
}

run "assertions" {
  assert {
    condition     = output.resource_name == "team1_projecta_prd_we"
    error_message = "Resource must contains delimiter"
  }

  assert {
    condition     = output.resource_name_without_delimiter == "team1projectaprdwe"
    error_message = "Resource must not contains delimiter"
  }
}