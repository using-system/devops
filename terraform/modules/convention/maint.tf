locals {
  resource_name = join(var.delimiter, [
    var.team,
    var.project,
    var.environment,
    var.region
  ])
  
  resource_name_without_delimiter = join("", [
    var.team,
    var.project,
    var.environment,
    var.region
  ])
}