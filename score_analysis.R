library(ggplot2)

# Read the TSV file with header
data <- read.table("input.tsv", sep="\t", header=TRUE, na.strings = c("", "NA"))

# Remove rows with missing or non-numeric Score values
data <- data.frame(data[!is.na(data$Score) & is.numeric(data$Score), ])

# Convert the Score column to numeric
data$Score <- as.numeric(as.character(data$Score))

# Determine the number of bins using Sturges' formula
num_bins <- ceiling(log2(nrow(data)) + 1)

# Bin the Org column based on the Score column
bins <- cut(data$Score, breaks = num_bins, include.lowest = TRUE, labels = FALSE)

# Create bin names
bin_names <- ifelse(is.na(bins), "BinNA", paste("Bin", as.character(num_bins - bins + 1), sep = ""))

# Add bin names to the data
data$bins <- factor(bin_names)

# Write the bins and organisms to an output file
output <- data.frame(Bins = bin_names, Organisms = data$Org)
write.table(output, "output.tsv", sep="\t", quote=FALSE, row.names = FALSE)

# Calculate min and max Score per bin
min_max_Score <- aggregate(data$Score, by=list(data$bins), FUN=function(x) c(min=min(x), max=max(x)))

# Split min_max_Score into two columns
min_max_Score <- cbind(min_max_Score[1], min_max_Score[[2]])

# Modify the column names
colnames(min_max_Score) <- c("Bins", "Min_Score", "Max_Score")

# Write the min and max Score per bin to a file
write.table(min_max_Score, "min_max_Score.tsv", sep="\t", quote=FALSE, row.names = FALSE)

# Plot the binned data (bar plot) and save as PDF
bar_plot <- ggplot(data, aes(x = bins, fill = Org)) +
  geom_bar() +
  labs(x = "Bins", y = "Count") +
  ggtitle("Binned Data Plot") +
  scale_fill_discrete(name = "Organisms")

ggsave("bar_plot.pdf", plot = bar_plot, device = "pdf", width = 35, height = 20)

# Plot the binned data (box plot) and save as PDF
box_plot <- ggplot(data, aes(x = bins, y = Score)) +
  geom_boxplot(aes(fill = bins)) +
  geom_jitter(width = 0.2, height = 0, alpha = 0.5, aes(fill = bins)) +
  labs(x = "Bins", y = "Score") +
  ggtitle("Box Plot with Scatter") +
  scale_fill_discrete() +
  geom_point(data = min_max_Score, aes(x = Bins, y = Min_Score), color = 'blue', size = 3) +
  geom_text(data = min_max_Score, aes(x = Bins, y = Min_Score, label = sprintf("%.2f", Min_Score)), vjust = -1.5, size = 3, color = 'blue') +
  geom_point(data = min_max_Score, aes(x = Bins, y = Max_Score), color = 'red', size = 3) +
  geom_text(data = min_max_Score, aes(x = Bins, y = Max_Score, label = sprintf("%.2f", Max_Score)), vjust = -1.5, size = 3, color = 'red')

ggsave("box_plot.pdf", plot = box_plot, device = "pdf", width = 10, height = 6)
