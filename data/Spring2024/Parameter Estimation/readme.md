Several runs were conducted to see if we could get the GRNmap output files to match what is expected from the results of the forward simulation. 

First, the alpha value was manipulated. Because this toy network has been made to contain more noise, a smaller than normal alpha value might be necessary to obtain the desired results. With this, we did see improvements, but the output files still varried from the expected files. 

Then, the tolfun and tolx values were manipulated as well and the alpha was decresed to a smaller value (10^-15). This also helped improve the outputs, but there were still variences. 

Several runs were then conducted where the just the P's, just the B's, and the P's and B's were held constant to try and discover where the sensitivities arose. Holding the P's seemed to give a more accurate result, but when both the P's and B's were held, the values of the expression data were still not exactly what was expected. 

It was thought that this might not be the problem of the model, but rather the estimation is off because the data levels out and becomes too steady too fast. To determine if this was the case, runs using the data from just the first 15 minutes of expression data (5 min, 10 min, and 15 min timpoints) were to be conducted to see if that lead to improves results, however, errors occured with those files when input so the outputs were not yet able to be analyzed. 
