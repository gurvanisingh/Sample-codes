
R version 3.5.1 (2018-07-02) -- "Feather Spray"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin15.6.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[R.app GUI 1.70 (7543) x86_64-apple-darwin15.6.0]

[History restored from /Users/gurvanisingh/.Rapp.history]

> #load package
> library(survival)
> #load raw data
> mydata=read.csv("KM.csv")
> #display data
> mydata
   month group status
1      3     1      1
2      5     1      1
3      5     1      1
4      5     1      1
5      5     1      1
6      5     1      0
7      5     1      1
8      6     1      1
9      6     1      1
10     6     1      1
11     7     1      1
12     7     1      1
13    12     1      0
14    12     1      0
15    12     1      0
16    12     1      0
17    12     1      0
18    12     1      0
19    12     1      0
20     6     2      1
21     6     2      0
22     7     2      1
23     7     2      1
24     7     2      1
25    12     2      0
26    12     2      0
27    12     2      0
28    12     2      0
29    12     2      0
30    12     2      0
31    12     2      0
32    12     2      0
33    12     2      0
34    12     2      0
35    12     2      0
36    12     2      0
37    12     2      0
38    12     2      0
39    12     2      0
> #status=1 indicates event.
> #use function for kaplan meier plot to have time on x-axis and status on y-axis for each group.
> fit =survfit(Surv(mydata$month,mydata$status)~mydata$group)
> summary(fit)
Call: survfit(formula = Surv(mydata$month, mydata$status) ~ mydata$group)

                mydata$group=1 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
    3     19       1    0.947  0.0512        0.852        1.000
    5     18       5    0.684  0.1066        0.504        0.929
    6     12       3    0.513  0.1171        0.328        0.803
    7      9       2    0.399  0.1155        0.226        0.704

                mydata$group=2 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
    6     20       1    0.950  0.0487        0.859        1.000
    7     18       3    0.792  0.0928        0.629        0.996

> # Group 1 has a censored data point at month 5. Hence number of events at month 5 and number at risk at month 6 don't add up to 18. Similarly group 2 also has a censored event.
> 
> #Generate the plot.
> #color can be specified by name or number.#Line type and line width are specified by lty and lwd respectively.
> #font number determines whether font is regular/bold/italic.#cex command controls font size.
> #censored points can be shown by marktime.
> #first two values in legend control x and y coordinates for displaying legend.
> plot(fit, col=c(1:2), xlab="Time (months)", ylab="Fraction tumor free", main="C57BL/6 mice \n Infection with different virus", lty=c(1,2), lwd=2, font=2, font.lab=2, cex.lab=1.5, cex.main=2, mark.time=TRUE)
> legend(2,0.3,legend=c("Wildtype","Mutant"), col=c(1:2), lty=c(1:2))
> #Calculate log rank p value for the plot.
> survdiff(Surv(mydata$month,mydata$status) ~mydata$group, rho=0)
Call:
survdiff(formula = Surv(mydata$month, mydata$status) ~ mydata$group, 
    rho = 0)

                N Observed Expected (O-E)^2/E (O-E)^2/V
mydata$group=1 19       11     6.02      4.11      7.87
mydata$group=2 20        4     8.98      2.76      7.87

 Chisq= 7.9  on 1 degrees of freedom, p= 0.005 
> 