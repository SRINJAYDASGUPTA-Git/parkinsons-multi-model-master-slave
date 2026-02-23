%%
%% customIEEEsingle.cls
%% ------------------------------------------------------------
%% Simple Journal Template (Single Column)
%% Designed for journals accepting manuscripts without
%% a specific LaTeX template requirement.
%%
%% Author: Srinjay Dasgupta
%% Version: 1.0
%% Year: 2026
%%
%% This class provides:
%% - Clean single-column layout
%% - Flexible author block with ORCID + corresponding marker
%% - Neutral formatting suitable for most journals
%% - No enforced bibliography style (user defines in .tex file)
%%
%% ------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{customIEEEsingle}[2026/01/01 v1.0 Simple Journal Template Class]

\LoadClass[12pt]{article}

% --------------------------------------------------
% REQUIRED PACKAGES
% --------------------------------------------------
% Layout and spacing
\RequirePackage[a4paper,margin=1in]{geometry}
\RequirePackage{setspace}
\RequirePackage{titlesec}

% Header/Footer
\RequirePackage{fancyhdr}

% Hyperlinks
\RequirePackage{hyperref}

% Icons (Email + ORCID)
\RequirePackage{fontawesome5}
\RequirePackage{orcidlink}

% Command tools
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage[protrusion=true,expansion=false]{microtype}

% --------------------------------------------------
% GENERAL DOCUMENT SETTINGS
% --------------------------------------------------
\onehalfspacing
\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt}
\setlength{\emergencystretch}{3em}

% --------------------------------------------------
% HEADER STYLE
% --------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\setlength{\headheight}{15pt}
\rhead{\thepage}
\renewcommand{\headrulewidth}{0pt}

% --------------------------------------------------
% SECTION FORMATTING
% --------------------------------------------------
\titleformat{\section}
  {\large\bfseries}
  {\thesection.}{0.5em}{}

\titleformat{\subsection}
  {\normalsize\bfseries}
  {\thesubsection}{0.5em}{}

% --------------------------------------------------
% ABSTRACT ENVIRONMENT
% --------------------------------------------------
\renewenvironment{abstract}
 {\bfseries \textbf{Abstract} \\}
 {}

% --------------------------------------------------
% KEYWORDS COMMAND
% Usage: \keywords{keyword1; keyword2; keyword3}
% --------------------------------------------------
\newcommand{\keywords}[1]{
    \vspace{1em}
    \noindent\textbf{Keywords:} #1
}

% --------------------------------------------------
% AUTHOR & AFFILIATION SYSTEM
% --------------------------------------------------
%
% Usage in main.tex:
%
% \addauthor{Name}[AffilID][Email][ORCID]
% \affiliation{Affiliation text}
%
% Example:
% \addauthor{John Doe}[1][john@email.com][0000-0000-0000-0000]
% \affiliation{Department of ...}
%
% --------------------------------------------------

\newcommand{\artauthors}{}
\newcommand{\auaffiliations}{}
\newcounter{affilcounter}

% Flag to avoid leading comma
\newif\ifisFirstAuthor
\isFirstAuthortrue

% --------------------------------------------------
% Corresponding Author (Envelope Footnote)
% --------------------------------------------------
\NewDocumentCommand{\correspondingauthor}{m}{%
  \begingroup%
  \renewcommand{\thefootnote}{\faEnvelope}%
  \footnote{Corresponding author: \href{mailto:#1}{#1}}%
  \endgroup%
}

% --------------------------------------------------
% ORCID Icon (Inline)
% --------------------------------------------------
\NewDocumentCommand{\inlineorcid}{m}{%
  \hspace{0.1em}\raisebox{-0.1ex}{\orcidlink{#1}}%
}

% --------------------------------------------------
% Add Author
% Order: Name → ORCID → Affiliation Superscript → Envelope
% --------------------------------------------------
\NewDocumentCommand{\addauthor}{m O{} O{} O{}}{
  \ifisFirstAuthor
    \appto\artauthors{%
      #1%
      \ifstrempty{#4}{}{\inlineorcid{#4}}%
      \ifstrempty{#2}{}{${}^{#2}$}%
      \ifstrempty{#3}{}{\correspondingauthor{#3}}%
    }
    \isFirstAuthorfalse
  \else
    \appto\artauthors{%
      , #1%
      \ifstrempty{#4}{}{\inlineorcid{#4}}%
      \ifstrempty{#2}{}{${}^{#2}$}%
      \ifstrempty{#3}{}{\correspondingauthor{#3}}%
    }
  \fi
}

% --------------------------------------------------
% Add Affiliation
% --------------------------------------------------
\newcommand{\affiliation}[1]{%
  \stepcounter{affilcounter}%
  \edef\tempnum{\theaffilcounter}%
  \eappto\auaffiliations{%
    \noexpand\par$^{\tempnum}$\unexpanded{#1}%
  }%
}

% --------------------------------------------------
% Title Block
% --------------------------------------------------
\renewcommand{\maketitle}{
  \begin{center}
    {\LARGE\bfseries\@title\par}
    \vspace{1em}
    {\large\artauthors\par}
    \vspace{0.8em}
    {\small\auaffiliations\par}
    \vspace{1em}
  \end{center}
}

\endinput