% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get.variable.metadata.R
\name{get.climdex.variable.metadata}
\alias{get.climdex.variable.metadata}
\title{Returns metadata for specified Climdex variables}
\usage{
get.climdex.variable.metadata(vars.list, template.filename, metadata.config)
}
\arguments{
\item{vars.list}{The list of variables, as returned by \code{\link{get.climdex.variable.list}}.}

\item{template.filename}{The filename template to be used when generating filenames.}

\item{metadata.config}{config object read using \code{read_json_metadata_config_file}. This contains all the metadata such as the output long names of the indices in the output NCDF files.}
}
\value{
A data frame containing the following:
\itemize{
\item{long.name}{Long names for the variable}
\item{var.name}{Variable name for use in the file}
\item{units}{Units for the variable}
\item{time.res}{The time resolution of the variable.}
\item{base.period.attr}{Whether to include a base period attribute}
\item{standard.name}{Standard name to use for the variable}
\item{filename}{Filename to be written out}
}
}
\description{
Returns metadata for specified Climdex variables.
}
\details{
This function returns metadata suitable for use in NetCDF files for the specified variables.
}
\examples{
## Get metadata (including filenames) for specified variables.
fn <- "pr_day_BCCAQ+ANUSPLIN300+MRI-CGCM3_historical+rcp85_r1i1p1_19500101-21001231.nc"
var.list2 <- get.climdex.variable.list("prec", time.resolution="annual")
md <- get.climdex.variable.metadata(var.list2, fn)

}
