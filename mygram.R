mygram <- function(coltxt, givenword, listword)
{
  givenword <- str_trim(givenword, side = "both")
strcnt <- str_count(givenword, " ") + 1
while (strcnt >= 5)
{
  givenword <- unlist(str_split(givenword, " ", n=2))[2]
  strcnt <- str_count(givenword, " ") + 1
}
givenword <- paste0(givenword, " ")
newt <- as.data.table(str_extract(coltxt, givenword))
newt <- na.omit(newt)
while (nrow(newt) == 0)
{
  givenword <- unlist(str_split(givenword, " ", n=2))[2]
  newt <- as.data.table(str_extract(coltxt, givenword))
  newt <- na.omit(newt)
}
newphrase <- paste0(givenword, "[[:alpha:]]+")
newcnt <- as.data.table(str_extract(coltxt, newphrase))
newcnt <- na.omit(newcnt)
newcnt[, nextword := substr(V1, str_length(givenword)+1, 100000L)]
setkey(newcnt, nextword)
highprob <- nrow(newcnt)
if (highprob != 0)
{
newcnt[, count := .N, by = nextword]
newcnt[, condprobb := count/nrow(newt)]
setkey(newcnt, condprobb)
newcnt <- unique(newcnt, by = "nextword")
highprob <- nrow(newcnt)
while (newcnt$nextword[highprob] %in% listword) {
    if (highprob == 1) {
    newcnt$nextword[highprob] <- "random"
  }
  if (highprob != 1){
    highprob <- highprob - 1
  }
}
nextword <- newcnt$nextword[highprob]

}
if (highprob ==0) {
  highprob <- 1
  nextword <- "guess"
}
c(nextword, newcnt$condprobb[highprob])
}
