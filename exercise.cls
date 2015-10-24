% special LaTeX class for exercises
% Malte Schmitz - Januar 2010

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exercise}

% input encoding
\RequirePackage[utf8]{inputenc}

% new german spelling
\RequirePackage[ngerman]{babel}

% choose font
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\usepackage{courier}

% KOMA-Script class for article
\LoadClass{scrartcl}
\KOMAoption{fontsize}{10pt}
\KOMAoption{parskip}{half}

% set type area
\usepackage[paper=a4paper,
            left=2.5cm,
            right=4cm,
            top=4cm,
            marginparsep=1cm,
            marginparwidth=3cm,
            bottom=2cm,
            headsep=1.5cm,
            footskip=1cm]{geometry}

% headings witout numbers
\RequirePackage{scrpage2}
\KOMAoption{headings}{normal}
\setcounter{secnumdepth}{0}

% special task header
\RequirePackage{ifthen}
\RequirePackage{twoopt}
\newcounter{task}
\setcounter{task}{0}

\newcommandtwoopt{\task}[2][][]{%
\ifthenelse{\equal{#2}{}}{%
\addtocounter{task}{1}\ifthenelse{\equal{#1}{}}{\section{Aufgabe \arabic{task}}}{\section{Aufgabe \arabic{task} \quad\mdseries #1}}
}{%
\ifthenelse{\equal{#1}{}}{\section{#2}}{\section{#2 \quad\mdseries #1}}
}
}

% enable colors
\RequirePackage{xcolor}

% set special behaviour for hyperlinks in pdfs
\RequirePackage[colorlinks=true,
                breaklinks=true,
                linkcolor=blue!50!black,
                citecolor=blue!50!black,
                filecolor=blue!50!black,
                menucolor=blue!50!black,
                runcolor=blue!50!black,
                urlcolor=blue!50!black]{hyperref}

% content of head and foot
\pagestyle{scrheadings}
\clearscrheadfoot
\automark{section}
\newcommand{\group}[1] {\ihead{#1}}
\newcommand{\exercise}[2] {\chead{\large~\\\vskip-0.9em\textbf{#1}\\\vskip0.1em #2}}
\newcommand{\students}[1]{\ohead{\itshape #1}}
\RequirePackage{lastpage}
\ofoot{\raisebox{3pt}{\arabic{page}}{\LARGE/}\raisebox{-3pt}{\pageref*{LastPage}}}

% layout of head and foot
\setheadtopline{1pt}
\setheadsepline{0.2pt}
\setfootwidth{textwithmarginpar}
\setkomafont{pageheadfoot}{\small\sffamily}
\setkomafont{pagefoot}{\large\sffamily}

% german quotes
\RequirePackage[babel,german=guillemets]{csquotes}
% for normal german quotes use german=quotes

% 1.5 times line spacing
\DeclareOption{biglinespread}{\linespread{1.25}}
\ProcessOptions

% math
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\mathtoolsset{showonlyrefs} % only show number on referenced formula
% float left of formulas
\@fleqntrue\let\mathindent\@mathmargin \@mathmargin=\leftmargini
% place vectors in bold
\renewcommand{\vec}[1]{\boldsymbol{#1}}

% listings
\usepackage{listings}
\lstset{%
  basicstyle=\ttfamily,%
  keywordstyle=%
    \color{orange}\bfseries,%
  identifierstyle=%
    \color{blue},%
  numbers=left,%
  numberstyle=\footnotesize,%
  frame=lines,%
  backgroundcolor=% 
    \color{orange!10},%
  rulecolor=%
    \color{orange!70},%
  framerule=1pt}

% nice tick
\newcommand{\tick}{\checkmark}

\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\K}{\mathbb{K}}
\newcommand{\Q}{\mathbb{Q}}

\RequirePackage{ulsy}
\newcommand{\blitz}{\quad\text{\blitze}}

% better list envorinment
\RequirePackage{paralist}

\newcommand{\inhead}[1]{\begin{sffamily}\bfseries #1 \end{sffamily}}

% special proof environment
\providecommand{\qed}{\hfill$\square$}
\newenvironment{proof}{%
  \trivlist
  \item[\hskip\labelsep
        \upshape\bfseries\sffamily
    Beweis\quad]\ignorespaces
}{\qed\endtrivlist}