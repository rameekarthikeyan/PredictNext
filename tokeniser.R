tokeniser <- function(x)
{
  gsub("[[:punct:]]|[[:digit:]]|[[:digit:]][[:alpha:]]*", "", x)
}