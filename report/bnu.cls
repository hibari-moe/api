\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bnu}[2018/03/02 Extended standard LaTeX document class]
\LoadClass{report}
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
\RequirePackage{float}
\RequirePackage{graphicx}
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
\RequirePackage[T1]{fontenc}
\RequirePackage[rm]{noto}
\RequirePackage{sourcecodepro}
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
\RequirePackage{fancyvrb}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{textcomp}
\RequirePackage[status=draft,noinline,author=]{fixme}
\fxusetheme{color}
\RequirePackage{fnbreak}
\RequirePackage{bookmark}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks,
  linkcolor={black},
  citecolor={blue!50!black},
  urlcolor={blue!80!black},
}
\RequirePackage{caption}
\makeatletter
  \renewcommand\@makefntext[1]{
  \hspace*{-2em}
  \parindent 0em
  \noindent
  \hb@xt@1.8em{\hss
  \@thefnmark\hspace{0.8em}}
  #1}
\makeatother
\linespread{1.1}
\setlength{\parskip}{1em}
\setlength{\footnotesep}{1.1em}
\hbadness=10000
\hfuzz=50pt
\newcommand{\module}[2]{\Large#1\\#2\\}
\newcommand{\coursework}[1]{\vspace*{.65cm}\huge#1\\\vfill}
\newcommand{\studentID}[1]{\textit{#1}}
\newcommand{\course}[2]{\vfill\textbf\today\\\vspace*{.75cm}\textit{#1}\\#2}
