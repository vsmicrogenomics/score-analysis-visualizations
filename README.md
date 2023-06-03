score_analysis.R

Description:
This script performs data analysis and visualization on a tab-separated value (TSV) file. It reads the input file, calculates summary statistics, generates plots, and saves the results to output files. The script specifically analyzes the "Score" column in the input TSV file, bins the scores, and creates a bar plot and box plot with scatter points. It also generates two output files: "output.tsv" containing the binned data and "min_max_Score.tsv" containing the minimum and maximum scores for each bin.

Input:
The script expects an input file named "input.tsv" in the current directory. The file should have a header row and contain two columns: "Org" and "Score". The "Score" column should consist of numeric values representing the scores for each organism.

Output:
output.tsv: This file contains the binned data, with two columns: "Bins" representing the bin names and "Organisms" representing the corresponding organism names.

min_max_Score.tsv: This file contains the minimum and maximum scores for each bin, with three columns: "Bins" representing the bin names, "Min_Score" representing the minimum score, and "Max_Score" representing the maximum score.

bar_plot.pdf: This PDF file contains a bar plot showing the count of organisms in each bin. The x-axis represents the bins, and the y-axis represents the count of organisms.

box_plot.pdf: This PDF file contains a box plot with scatter points showing the distribution of scores in each bin. The x-axis represents the bins, and the y-axis represents the scores. The box plot shows the quartiles, median, and outliers of the score distribution, while the scatter points represent individual scores. Additionally, blue points and labels represent the minimum score for each bin, and red points and labels represent the maximum score for each bin.

Please make sure to have the required input file ("input.tsv") in the correct format and run the script to generate the output files and plots.

## Citation

If you find the "score-analysis-visualizations" repository useful in your work, please consider citing it:
score-analysis-visualizations. {2023}. GitHub repository. Available at: https://github.com/vsmicrogenomics/score-analysis-visualizations

