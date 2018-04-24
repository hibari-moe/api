% Chicago Style Guide
% https://titlecaseconverter.com/
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bnu}[2018/03/02 Extended standard LaTeX document class]
\LoadClass{report}
% General
\RequirePackage[british]{babel}
\let\latinencoding\relax
\RequirePackage[a4paper, portrait]{geometry}
\RequirePackage{subfiles}
\RequirePackage{enumitem}
\RequirePackage[useregional]{datetime2}
\RequirePackage{natbib}
\RequirePackage[nottoc]{tocbibind}
\bibliographystyle{agsm}
\addto\captionsbritish{\renewcommand{\bibname}{References}}
% Image
\RequirePackage{float}
\RequirePackage{graphicx}
% Chapter, Part and Section numbering
\RequirePackage{tocloft}
\RequirePackage{titlesec}
\renewcommand{\thepart}{\Alph{part}}
\addto\captionsbritish{\renewcommand{\partname}{Part}}
\renewcommand{\thechapter}{\arabic{chapter}}
\addto\captionsbritish{\renewcommand{\chaptername}{Section}}
\titleformat{\chapter}[display]
{\centering\normalfont\Large\bfseries}{\chaptername\ \thechapter}{0.8em}{\LARGE}
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
\addto\captionsbritish{\renewcommand{\contentsname}{\hfill\bfseries\LARGE Summary\hfill}}\addto\captionsbritish{\renewcommand{\listfigurename}{\hfill\bfseries\LARGE List of Figures}}
\addto\captionsbritish{\renewcommand{\listtablename}{\hfill\bfseries\LARGE List of Tables}}
\addto\captionsbritish{\renewcommand{\cftaftertoctitle}{\hfill}}
\addto\captionsbritish{\renewcommand{\cftafterloftitle}{\hfill}}
\addto\captionsbritish{\renewcommand{\cftafterlottitle}{\hfill}}
% \renewcommand*{\thefootnote}{\textbf{\arabic{footnote}}}
% Fonts
\RequirePackage[T1]{fontenc}
\RequirePackage[rm]{noto}
\RequirePackage{sourcecodepro}
% Set monospace font in Verbatism blocks
\makeatletter
\defaultfontfeatures[\ttfamily]{
  Numbers = \sourcecodepro@figurestyle,
  Scale = \SourceCodePro@scale,
  Extension = .otf
}
\setmonofont[
  UprightFont = *-\sourcecodepro@regstyle,
  ItalicFont = *-\sourcecodepro@regstyle It,
  BoldFont = *-\sourcecodepro@regstyle,
  BoldItalicFont = *-\sourcecodepro@regstyle It
]{SourceCodePro}
\makeatother
% Syntax Highlighting
\RequirePackage{fancyvrb}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{textcomp}
% TODO notes
% \fxnote, \fxwarning, \fxerror, \fxfatal
\RequirePackage[status=draft,noinline,author=]{fixme}
\fxusetheme{color}
% Detect footnotes split into next page
\RequirePackage{fnbreak}
% Links
\RequirePackage{bookmark}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks,
  linkcolor={black},
  citecolor={blue!50!black},
  urlcolor={blue!80!black},
}
% Non-float figure captioning
\RequirePackage{caption}
% Spacing
\makeatletter
  \renewcommand\@makefntext[1]{%
  \hspace*{-2em}
  \parindent 0em
  \noindent
  \hb@xt@1.8em{\hss %  There's the option of putting \hss before
  \@thefnmark\hspace{0.8em}}%       or after \@thefnmark, aligning the footnote
  #1}%                  marks to the right or to the left, respectively
\makeatother
\linespread{1.1}
%\setlength{\parindent}{0em} % 0.2cm
\setlength{\parskip}{1em}
\setlength{\footnotesep}{1.1em}
\hbadness=10000
\hfuzz=50pt

% Module Code, Module Name
\newcommand{\module}[2]{\Large#1\\#2\\}
% Coursework Title
\newcommand{\coursework}[1]{\vspace*{.65cm}\huge#1\\\vfill}
% Student IDs
\newcommand{\studentID}[1]{\textit{#1}}
% Course, University
\newcommand{\course}[2]{\vfill\textbf\today\\\vspace*{.75cm}\textit{#1}\\#2}
