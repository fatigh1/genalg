\name{rbga2}
\alias{rbga2}
\title{R Based Genetic Algorithm 2 (floating point chromosome)}
\description{
  A second R based genetic algorithm that optimizes, using a user set evaluation
  function, a set of floats. It is an derivation from function rbga with
  optimizations and additional features.  It takes as input minimum and maximum 
  values for the floats to optimizes. The optimum is the chromosome for which the 
  evaluation value is minimal.
  
  It requires a \code{evalFunc} method to be supplied that takes as argument
  the chromosome, a vector of floats.
  Additionally, the GA optimization can be monitored by setting a 
  \code{monitorFunc} that takes a \code{rbga} object as argument.
  
  Results can be visualized with \code{\link{plot.rbga}} and summarized with
  \code{\link{summary.rbga}}.
}
\usage{

rbga2(stringMin=c(), stringMax=c(),
     suggestions=NULL,
     popSize=200, iters=100,
     mutationChance=NA,
     elitism=NA,
     monitorFunc=NULL, evalFunc=NULL,
     showSettings=FALSE, verbose=FALSE,
     fElitismDifferenceTooLow= NULL,
     parentProb= NULL)
}
\arguments{
  \item{stringMin}{vector with minimum values for each gene.}
  \item{stringMax}{vector with maximum values for each gene.}
  \item{suggestions}{optional list of suggested chromosomes}
  \item{popSize}{the population size.}
  \item{iters}{the number of iterations.}
  \item{mutationChance}{the chance that a gene in the chromosome mutates. By default 1/(size+1).
        It affects the convergence rate and the probing of search space: a low chance results
        in quicker convergence, while a high chance increases the span of the search space.}
  \item{elitism}{the number of chromosomes that are kept into the next generation.
        By default is about 20\% of the population size.}
  \item{monitorFunc}{Method run after each generation to allow monitoring of the
        optimization}
  \item{evalFunc}{User supplied method to calculate the evaluation function for
        the given chromosome}
  \item{showSettings}{if true the settings will be printed to screen. By default False.}
  \item{verbose}{if true the algorithm will be more verbose. By default False.}
  \item{fElitismDifferenceTooLow}{This parameter defines an function of the form function( chromCurr, chromNext), which is feed pairwise by all neighbourhooded elite-chromosomes (population index 1:2, 2:3, 3:4, and so on) and it returns an logical scalar. If the return value is TRUE then the lower elite-chromosome gets deleted, if the return value is FALSE, the lower elite-chromosome keeps alive. This function avoids effectively, that a lot of elite-chromosomes hold the same data after a while of computation.}
  \item{parentProb}{parentProb defines the probability for every population-position, to get crossed over. It can be instantiated for instance with parentProb= dnorm(1:popSize, mean=0, sd=(popSize/3)). If it is NULL, the probability for all chromosomes, to get crossed, is the same (faster).}
}
\section{References}{
  C.B. Lucasius and G. Kateman (1993).
  Understanding and using genetic algorithms - Part 1. Concepts, properties and context.
  \emph{Chemometrics and Intelligent Laboratory Systems 19:1-33}.

  C.B. Lucasius and G. Kateman (1994).
  Understanding and using genetic algorithms - Part 2. Representation, configuration and hybridization.
  \emph{Chemometrics and Intelligent Laboratory Systems 25:99-145}.
}
\seealso{
  \code{\link{rbga}}
  \code{\link{rbga.bin}}
  \code{\link{plot.rbga}}
}
\examples{
# optimize two values to match pi and sqrt(50)
evaluate <- function(string=c()) {
    returnVal = NA;
    if (length(string) == 2) {
        returnVal = abs(string[1]-pi) + abs(string[2]-sqrt(50));
    } else {
        stop("Expecting a chromosome of length 2!");
    }
    returnVal
}

monitor <- function(obj) {
    # plot the population
    xlim = c(obj$stringMin[1], obj$stringMax[1]);
    ylim = c(obj$stringMin[2], obj$stringMax[2]);
    plot(obj$population, xlim=xlim, ylim=ylim, xlab="pi", ylab="sqrt(50)");
}

rbga.results = rbga2( stringMin= c(1, 1), stringMax= c(5, 10), monitorFunc=monitor, 

    evalFunc=evaluate, verbose=TRUE, mutationChance=0.01,

    fElitismDifferenceTooLow= function( chromCurr, chromNext){ sum( abs( chromCurr - chromNext)) < 1e-3}
)

plot(rbga.results)
plot(rbga.results, type="hist")
plot(rbga.results, type="vars")
}
\keyword{multivariate}
