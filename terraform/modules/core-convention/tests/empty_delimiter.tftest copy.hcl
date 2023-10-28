variables {
        team        = "team1"
        project     = "projecta"
        environment = "prd"
        region      = "we"
        delimiter   = ""
}

run "assertions" {
  assert {
    condition     = output.resource_name == "team1-projecta-prd-we"
    error_message = "Resource must contains delimiter"
  }

  assert {
    condition     = output.resource_name_without_delimiter == "team1projectaprdwe"
    error_message = "Resource must not contains delimiter"
  }
}