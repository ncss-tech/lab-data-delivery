library(opusreader)

## doesn't work
# x <- opus_read('D:/Snapshot Feb 2021/MIR_Truncated_Library/C2001USAK206/32987XS01.0')

# x <- read.csv('D:/Snapshot Feb 2021/MIR_Truncated_Library/C2001USAK206/32987XS01.csv')
# 
# plot(x)


f <- list.files('D:/Snapshot Feb 2021/MIR_Truncated_Library/C2001USAK206', pattern = '\\.csv', recursive = TRUE, full.names = TRUE)
length(f)


