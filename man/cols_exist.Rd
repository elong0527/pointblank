% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cols_exist.R
\name{cols_exist}
\alias{cols_exist}
\title{Do one or more columns actually exist?}
\usage{
cols_exist(..., cols, brief = NULL, warn_count = NULL,
  notify_count = NULL, warn_fraction = NULL, notify_fraction = NULL,
  tbl_name = NULL, db_type = NULL, creds_file = NULL,
  initial_sql = NULL, file_path = NULL, col_types = NULL)
}
\arguments{
\item{...}{a data frame, tibble, or an agent object of class
\code{ptblank_agent}.}

\item{cols}{one or more columns from the table in focus. This can be provided
as a vector of column names using \code{c()} or bare column names enclosed
in \code{\link{vars}()}.}

\item{brief}{an optional, text-based description for the validation step.}

\item{warn_count}{the threshold number for individual validations returning a
\code{FALSE} result before applying the \code{warn} flag.}

\item{notify_count}{the threshold number for individual validations returning
a \code{FALSE} result before applying the \code{notify} flag.}

\item{warn_fraction}{the threshold fraction for individual validations
returning a \code{FALSE} over all the entire set of individual validations.
Beyond this threshold, the \code{warn} flag will be applied.}

\item{notify_fraction}{the threshold fraction for individual validations
returning a \code{FALSE} over all the entire set of individual validations.
Beyond this threshold, the \code{notify} flag will be applied.}

\item{tbl_name}{the name of the local or remote table.}

\item{db_type}{if the table is located in a database, the type of database is
required here. Currently, this can be either \code{PostgreSQL} or
\code{MySQL}.}

\item{creds_file}{if a connection to a database is required for reaching the
table specified in \code{tbl_name}, then a path to a credentials file can
be used to establish that connection. The credentials file is an \code{RDS}
containing a character vector with the following items in the specified
order: (1) database name (\code{dbname}), (2) the \code{host} name, (3) the
\code{port}, (4) the username (\code{user}), and (5) the \code{password}.
This file can be easily created using the \code{\link{create_creds_file}()}
function.}

\item{initial_sql}{when accessing a remote table, this provides an option to
provide an initial query component before conducting validations. An entire
SQL statement can be provided here, or, as a shortcut, the initial
\code{SELECT...} statement can be omitted for simple queries (e.g.,
\code{WHERE a > 1 AND b = 'one'}).}

\item{file_path}{an optional path for a tabular data file to be loaded for
this verification step. Valid types are CSV and TSV files.}

\item{col_types}{if validating a CSV or TSV file, an optional column
specification can be provided here as a string. This string representation
is where each character represents one column and the mappings are:
\code{c} -> character, \code{i} -> integer, \code{n} -> number, \code{d} ->
double, \code{l} -> logical, \code{D} -> date, \code{T} -> date time,
\code{t} -> time, \code{?} -> guess, or \code{_/-}, which skips the column.}
}
\value{
an agent object.
}
\description{
Set a verification step that checks whether one or several specified columns
exist in the target table.
}
\examples{
# Validate that columns `a`, `c`, and
# `f` exist in the `small_table` CSV file;
# do this by creating an agent, focussing
# on that table, creating a `cols_exist()`
# step, and then interrogating the table
agent <-
  create_agent() \%>\%
  focus_on(
    file_name = 
      system.file(
        "extdata", "small_table.csv",
        package = "pointblank"),
    col_types = "TDicidlc") \%>\%
  cols_exist(cols = vars(a, c, f)) \%>\%
  interrogate()

# Determine if these three validation
# steps passed by using `all_passed()`
all_passed(agent)
}
