% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create.indices.from.files.R
\name{create.indices.from.files}
\alias{create.indices.from.files}
\title{Create Climdex indices from NetCDF input files.}
\usage{
create.indices.from.files(
  input.files,
  out.dir,
  output.filename.template,
  author.data,
  climdex.vars.subset = NULL,
  climdex.time.resolution = c("all", "annual", "monthly", "seasonal", "halfyear"),
  axis.to.split.on = "Y",
  fclimdex.compatible = TRUE,
  base.range = c(1961, 1990),
  parallel = 4,
  verbose = FALSE,
  thresholds.files = NULL,
  max.vals.millions,
  cluster.type = "SOCK"
)
}
\arguments{
\item{input.files}{A list of filenames of NetCDF files to be used as input. A NetCDF file may contain one or more variables.}

\item{out.dir}{The directory to put the output files in.}

\item{output.filename.template}{The output filename to be used as a template, which must follow the CMIP5 file naming conventions.}

\item{author.data}{Data describing the author; a character vector with 0 or more of the following named values:\describe{
\item{institution}{The institution generating the data.}
\item{institution_id}{An abbreviation for the institution generating the data.}
\item{indices_archive}{The URL the data is published at, if applicable.}
\item{contact}{The email address or contact info for the author.}
\item{references}{What to reference when citing this work.}
}}

\item{climdex.vars.subset}{A character vector of lower-case names of Climdex indices to calculate (eg: tr, fd, rx5day). See the list of 27 indices in the References section.}

\item{climdex.time.resolution}{The time resolution to compute indices at; one of "all" (both monthly and annual), "annual" (only annual), or "monthly" (only monthly).}

\item{axis.to.split.on}{The axis to split up the data on for parallel / incremental processing.}

\item{fclimdex.compatible}{Whether the thresholds should be created to match fclimdex thresholds; affects padding at the ends of the base period.}

\item{base.range}{Vector of two numeric years specifying the start and end years.}

\item{parallel}{The number of parallel processing threads, or FALSE if no parallel processing is desired.}

\item{verbose}{Whether to be chatty.}

\item{thresholds.files}{A character vector of files containing thresholds to be used.}

\item{max.vals.millions}{The number of data values to process at one time (length of time dim * number of values * number of variables).}

\item{cluster.type}{The cluster type, as used by the \code{snow} library.}
}
\description{
Create Climdex indices from NetCDF input files.
}
\details{
This function computes Climdex indices from NetCDF input files, writing out one file per variable named like the \code{template.filename}, which must follow the CMIP5 file naming conventions (this is a deficiency which will be corrected in later versions).

The indices to be calculated can be specified; if not, they will be determined by data availability. Thresholds can be supplied (via \code{thresholds.files}) or, if there is data within the base period, calculated and used as part of the process. Note that in-base thresholds are separate from out-of-base thresholds; this is covered in more detail in the help for the \code{climind} package.

The metadata is stored in JSON files that are included with the pacakge. Right now, the metadata relevant to EOBS is used by default. To switch to another set of metadata, use the \code{metadata.id}
global option:

    \code{options(metadata.id = 'eobs')}

Note that currently only EOBS metadata is available (\code{metadata.id = 'eobs'}).
}
\note{
NetCDF input files may contain one or more variables, named as per \code{variable.name.map} in the json config file. The code will search the files for the named variables. The same is true of thresholds files; one file may be supplied, or multiple files may be supplied, via the \code{thresholds.files} argument; and the name mapping may be supplied via the \code{thresholds.name.map} argument.
}
\examples{
\dontrun{
## Prepare input data and calculate indices for a single file
## with a single thread (no parallelism).
input.files <- c("pr_NAM44_CanRCM4_ERAINT_r1i1p1_1989-2009.nc")
author.data <- list(institution="Looney Bin", institution_id="LBC")
create.indices.from.files(input.files, "out_dir/", input.files[1], author.data,
                          base.range=c(1991, 2000), parallel=FALSE)

## Prepare input data and calculate indices for two files
## in parallel given thresholds.
input.files <- c("pr_NAM44_CanRCM4_ERAINT_r1i1p1_1989-2009.nc",
                 "tasmax_NAM44_CanRCM4_ERAINT_r1i1p1_1989-2009.nc")
author.data <- list(institution="Looney Bin", institution_id="LBC")
create.indices.from.files(input.files, "out_dir/", input.files[1], author.data,
                          base.range=c(1991, 2000), parallel=8, thresholds.files="thresh.nc")
}

}
\references{
\url{http://etccdi.pacificclimate.org/list_27_indices.shtml}
}
