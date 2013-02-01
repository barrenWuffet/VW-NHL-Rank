### Shows object names and sizes in R.

## Source : http://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session

.ls.objects <- function (pos = 1, pattern, order.by,
                        decreasing=FALSE, head=FALSE, n=5) {
    napply <- function(names, fn) sapply(names, function(x)
                                         fn(get(x, pos = pos)))
    names <- ls(pos = pos, pattern = pattern)
    obj.class <- napply(names, function(x) as.character(class(x))[1])
    obj.mode <- napply(names, mode)
    obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
    obj.size <- napply(names, object.size)
    obj.prettysize <- sapply(obj.size, function(r) prettyNum(r, big.mark = ",") )
    obj.dim <- t(napply(names, function(x)
                        as.numeric(dim(x))[1:2]))
    vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
    obj.dim[vec, 1] <- napply(names, length)[vec]
    out <- data.frame(obj.type, obj.size,obj.prettysize, obj.dim)
    names(out) <- c("Type", "Size", "PrettySize", "Rows", "Columns")
    if (!missing(order.by))
        out <- out[order(out[[order.by]], decreasing=decreasing), ]
        out <- out[c("Type", "PrettySize", "Rows", "Columns")]
        names(out) <- c("Type", "Size", "Rows", "Columns")
    if (head)
        out <- head(out, n)
    out
}

lsos <- function(..., n=10) {
    .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}

lsos()

## Shows Column Name, Number and Type

cnn  <- function(dataset){
	for(i in 1:length(dataset)){
	print(paste(i,": ", colnames(dataset)[i], " | ", class(dataset[,i]), sep=""))
	}
}

## Ranks factor variables by occurence count.
rankTab <- function(x){
tab1 <- data.frame(table(x))
tab1 <- tab1[order(-tab1$Freq),]
tab1
}
