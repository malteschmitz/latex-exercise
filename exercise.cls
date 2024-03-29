\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exercise}[2021/04/25 Document Class for Exercises]

% load xkeyval before loading KOMA to make sure
% KOMA uses xkeyval instead if keyval
\RequirePackage{xkeyval}

% KOMA-Script class for article
\LoadClass{scrartcl}

% set basic KOMA-Script options
\KOMAoption{fontsize}{10pt}
\KOMAoption{parskip}{half}

% declare counters
\newcounter{task}
\setcounter{task}{0}
\newcounter{sheet}
\setcounter{sheet}{0}
\newcounter{chapter}
\setcounter{chapter}{0}
\newif\if@usechapter
\@usechapterfalse

% declare variables
\newcommand{\@sheettext}{}

% enable colors
\RequirePackage[table]{xcolor}
% define color of university of luebeck
\xdefinecolor{uni-luebeck}{RGB}{0, 120, 140}
\colorlet{maincolor}{orange}

% declare names
\providecommand{\taskname}{Aufgabe}
\providecommand{\sheetname}{Übungszettel}
\providecommand{\proofname}{Beweis}
\providecommand{\claimname}{Behauptung}

% already load math packages to redefine \vec in the options
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% key=value management
\newcommand{\@familyname}{Uni}
\DefineFamily{\@familyname} % define new family
\DefineFamilyMember{\@familyname} % register this class as a family member

\FamilyBoolKey{\@familyname}{biglinespread}{@biglinespread}

\DefineFamilyKey{\@familyname}{sheet}{%
  \setcounter{sheet}{#1}%
  \renewcommand{\@sheettext}{\sheetname{} \thesheet}}

\DefineFamilyKey{\@familyname}{task}{%
  \setcounter{task}{#1}%
  \addtocounter{task}{-1}}

\DefineFamilyKey{\@familyname}{chapter}{%
  \setcounter{chapter}{#1}%
  \@usechaptertrue}

\FamilyBoolKey{\@familyname}{prefix}{@prefix}

\DefineFamilyKey{\@familyname}{maincolor}{%
  \colorlet{maincolor}{#1}
}

% place vectors in bold
\let\oldvec\vec
\let\vec\boldsymbol
\define@choicekey*{\@familyname.\@currname.\@currext}{vec}[\val\nr]{arrow,bold,underline}{%
  \ifcase\nr\relax
    % arrow
    \let\vec\oldvec
  \or
    % bold
    \let\vec\boldsymbol
  \or
    % underline
    \let\vec\underline
  \fi
}

% add support for English
% The order of the options doesn't matter because macro arguments are
% not expanded before their actual use.
\define@choicekey*{\@familyname.\@currname.\@currext}{language}[\val\nr]{de,en}{%
  \ifcase\nr\relax
    % de = deutsch
    \AtBeginDocument{\selectlanguage{ngerman}} % babel
    \renewcommand{\taskname}{Aufgabe}
    \renewcommand{\sheetname}{Übungszettel}
    \renewcommand{\proofname}{Beweis}
    \renewcommand{\claimname}{Behauptung}
  \or
    % en = english
    \AtBeginDocument{\selectlanguage{english}} % babel
    \renewcommand{\taskname}{Task}
    \renewcommand{\sheetname}{Exercise Sheet}
    \renewcommand{\proofname}{Proof}
    \renewcommand{\claimname}{Claim}
  \fi
}

\FamilyProcessOptions{\@familyname}

% Make sure to load babel after executing \FamilyProcessOptions for
% it to work properly. Otherwise \FamilyBoolKey does not work.
% enable new german spelling by default
\RequirePackage[english,ngerman]{babel}

% input encoding
\RequirePackage[utf8]{inputenc}

% choose font
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{textcomp}
\RequirePackage{courier}

% set type area
\RequirePackage[paper=a4paper,
                left=2.5cm,
                right=4cm,
                top=4cm,
                marginparsep=0.5cm,
                marginparwidth=1.5cm,
                bottom=2cm,
                headsep=1cm,
                head=1.1cm,
                footskip=1cm]{geometry}
\setlength{\footheight}{0.7cm}

% headings witout numbers
\RequirePackage{scrlayer-scrpage}
\KOMAoption{headings}{normal}
\setcounter{secnumdepth}{0}

% special task header
\RequirePackage{ifthen}
\RequirePackage{twoopt}
\if@prefix
  \if@usechapter
    \renewcommand{\thetask}{\thesheet.\arabic{chapter}.\arabic{task}}
  \else
    \renewcommand{\thetask}{\thesheet.\arabic{task}}
  \fi
\else
  \if@usechapter
    \renewcommand{\thetask}{\arabic{chapter}.\arabic{task}}
  \else
    \renewcommand{\thetask}{\arabic{task}}
  \fi
\fi
\renewcommand{\thesheet}{\arabic{sheet}}
\providecommand{\taskcommand}{section}
\newcommand{\invoketaskcommand}{\csname\taskcommand\endcsname}
\newcommandtwoopt{\task}[2][][]{%
  \ifthenelse{\equal{#2}{}}{%
    \addtocounter{task}{1}%
    \ifthenelse{\equal{#1}{}}{%
      \invoketaskcommand{\taskname{} \thetask}%
    }{%
      \invoketaskcommand[\taskname{} \thetask: #1]{\taskname{} \thetask\quad\mdseries\color{black}#1}%
    }%
  }{%
    \ifthenelse{\equal{#1}{}}{%
      \invoketaskcommand{#2}%
    }{%
      \invoketaskcommand[#2: #1]{#2\quad\mdseries\color{black}#1}%
    }%
  }%
}

\providecommand{\nextchapter}{%
  \stepcounter{chapter}%
  \setcounter{task}{0}%
}

\providecommand{\setchapter}[1]{%
  \setcounter{chapter}{#1}%
  \setcounter{task}{0}%
}

\providecommand{\settask}[1]{%
  \setcounter{task}{#1}%
  \addtocounter{task}{-1}%
}

% 1.5 times line spreading?
\if@biglinespread
  \linespread{1.25}%
\else
  \linespread{1}%
\fi

% content of head and foot
\pagestyle{scrheadings}
\clearpairofpagestyles
\automark{section}
\newcommand{\setgroup}[1]{\ihead{#1}}

\newcommand{\addstudent}[2][]{%
  \scr@ifundefinedorrelax{@students@value}{%
    \newcommand{\@students@value}{#2 \ifthenelse{\equal{#1}{}}{}{(#1)}}%
    \newcommand{\@students@pdf}{#2}%
  }{%
    \expandafter\def\expandafter\@students@value\expandafter{%
      \@students@value\\#2 \ifthenelse{\equal{#1}{}}{}{(#1)}}%
    \expandafter\def\expandafter\@students@pdf\expandafter{%
      \@students@pdf{}, #2}}%
  \hypersetup{pdfauthor={\@students@pdf}}%
  \ohead{\itshape \@students@value}}
  
\newcommand{\settitle}[2][\@sheettext] {%
  \hypersetup{pdftitle={#2},pdfsubject={#1}}%
  \chead{\large~\\\vskip-0.9em\textbf{#2}\\\vskip0.1em \textcolor{maincolor}{#1}}}

\RequirePackage{zref-totpages}
\ofoot{%
  \ifnum\ztotpages>1% We know the total number of pages and it is more than one --> page numbers! 
    \raisebox{3pt}{\arabic{page}}{\LARGE/}\raisebox{-3pt}{\ztotpages}%
  \else%
    \ifnum\ztotpages=1% There is only one page in total --> no page numbers!
      %
    \else% 
      \arabic{page}% We do not know the total number of pages yet --> recompile needed
    \fi%
  \fi%
}

% layout of head and foot
\KOMAoption{headtopline}{1pt}
\KOMAoption{headsepline}{0.2pt}
\setfootwidth{textwithmarginpar}
\setkomafont{pageheadfoot}{\small\sffamily}
\setkomafont{pagefoot}{\large\sffamily}
\setkomafont{headtopline}{\color{maincolor}}

% add maincolor to section layout
\addtokomafont{section}{\color{maincolor}}

% zebra tables
\newcommand{\mainrowcolors}{\rowcolors{1}{maincolor!25}{maincolor!5}}
\newenvironment{zebratabular}{\mainrowcolors\begin{tabular}}{\end{tabular}}
\newcommand{\setrownumber}[1]{\global\rownum#1\relax}
\newcommand{\headerrow}{\rowcolor{maincolor!50}\setrownumber1}

% german quotes
\RequirePackage[babel,german=guillemets]{csquotes}
% for normal german quotes use german=quotes

% math options
\RequirePackage{mathtools}
\mathtoolsset{showonlyrefs} % only show number on referenced formula
% float left of formulas
\@fleqntrue\let\mathindent\@mathmargin \@mathmargin=\leftmargini

% listings
\RequirePackage{listings}
\lstset{%
  basicstyle=\ttfamily,%
  keywordstyle=\color{maincolor}\bfseries,%
  identifierstyle=\color{blue},%
  numbers=left,%
  numberstyle=\footnotesize,%
  frame=lines,%
  captionpos={b},% set caption pos to bottom
  backgroundcolor=\color{maincolor!10},%
  rulecolor=\color{maincolor!70},%
  framerule=1pt,%
  showstringspaces=false,%
  upquote=true}
% german umlauts
\lstset{
  literate={ö}{{\"o}}1
           {ä}{{\"a}}1
           {ü}{{\"u}}1
           {ß}{{\ss}}1
}

% better list envorinment
\RequirePackage{paralist}
\setdefaultenum{\color{maincolor}a)}{\color{maincolor}1.}{\color{maincolor}i.}{\color{maincolor}A.}
\setdefaultitem{\color{maincolor}\textbullet}%
  {\color{maincolor}\normalfont\bfseries \textendash}%
  {\color{maincolor}\textasteriskcentered}{\color{maincolor}\textperiodcentered}
% variant list environments for convenience
\newcommand{\setvaritem}{%
  \setdefaultitem{\color{maincolor}\normalfont\bfseries \textendash}%
    {\color{maincolor}\textasteriskcentered}{\color{maincolor}\textperiodcentered}{}}
\newcommand{\setvarenum}{%
  \setdefaultenum{\color{maincolor}1)}{\color{maincolor}a)}{}{}}
\newenvironment{varitemize}{%
  \setvaritem\begin{itemize}}{\end{itemize}}
\newenvironment{varcompactitem}{%
  \setvaritem\begin{compactitem}}{\end{compactitem}}
\newenvironment{varenumerate}{%
  \setvarenum\begin{enumerate}}{\end{enumerate}}
\newenvironment{varcompactenum}{%
  \setvarenum\begin{compactenum}}{\end{compactenum}}
  
% redefine existing list environments to color every item in the maincolor
\newcommand{\ifempty}[3]{\ifthenelse{\equal{#1}{}}{#2}{#3}}
\newcommand{\@oldenumerate}{}
\newcommand{\@olditemize}{}
\let\@oldenumerate\enumerate
\let\@olditemize\itemize
\let\@oldcompactenum\compactenum
\let\@oldcompactitem\compactitem
\renewcommand{\enumerate}[1][]{\ifempty{#1}{\@oldenumerate}{\@oldenumerate[\color{maincolor}#1]}}
\renewcommand{\itemize}[1][]{\ifempty{#1}{\@olditemize}{\@olditemize[\color{maincolor}#1]}}
\renewcommand{\compactenum}[1][]{\ifempty{#1}{\@oldcompactenum}{\@oldcompactenum[\color{maincolor}#1]}}
\renewcommand{\compactitem}[1][]{\ifempty{#1}{\@oldcompactitem}{\@oldcompactitem[\color{maincolor}#1]}}

% funny lists using dingbats
\RequirePackage{pifont}
\newenvironment{dingitem}[2][pzd]{\begin{itemize}[\Pisymbol{#1}{#2}]}{\end{itemize}}
\newenvironment{compactdingitem}[2][pzd]{\begin{compactitem}[\Pisymbol{#1}{#2}]}{\end{compactitem}}
% enumerations
\newcounter{@dingenumindex}
\newcommand{\@dingenumitem}{\stepcounter{@dingenumindex}\color{maincolor}\Pisymbol{pzd}{\value{@dingenumindex}}}
\newenvironment{dingenum}[2][pzd]{\setcounter{@dingenumindex}{#2}\addtocounter{@dingenumindex}{-2}\@olditemize[\@dingenumitem]}{\enditemize}
\newcounter{@compactdingenumindex}
\newcommand{\@compactdingenumitem}[1]{\stepcounter{@compactdingenumindex}\color{maincolor}\Pisymbol{#1}{\value{@compactdingenumindex}}}
\newenvironment{compactdingenum}[2][pzd]{\setcounter{@compactdingenumindex}{#2}\addtocounter{@compactdingenumindex}{-2}\@oldcompactitem[\@compactdingenumitem{#1}]}{\endcompactitem}

% set special behaviour for hyperlinks in pdfs
\RequirePackage{hyperref}
\hypersetup{breaklinks=true,
            pdfborder={0 0 0},
            ngerman,
            pdfhighlight={/N}}
\RequirePackage[all]{hypcap}

% nice tick
\newcommand{\tick}{\checkmark}

% often used sets
\newcommand{\set}[1]{\mathbb{#1}}
\newcommand{\R}{\set{R}}
\newcommand{\N}{\set{N}}
\newcommand{\Z}{\set{Z}}
\newcommand{\Q}{\set{Q}}

% custom operators
\newcommand{\op}[1]{\operatorname{#1}}

% nice blitz symbol
\RequirePackage{stmaryrd}
\SetSymbolFont{stmry}{bold}{U}{stmry}{m}{n}
\newcommand{\blitz}{\quad\ensuremath{\lightning}}

% nice dx symbol
\newcommand{\dx}[1][x]{\,\mathrm{d}#1}
\newcommand{\dt}{\dx[t]}

% nice transposed symbol
\newcommand{\trans}[1]{{#1}^\text{T}}

% nice z.z. symbol
\newcommand{\zz}{\mathrm{Z\kern-.3em\raise-0.5ex\hbox{Z}}}

% paragraph without latex magic
\newcommand{\inhead}[1]{\begin{sffamily}\bfseries #1 \end{sffamily}}

% special proof environment
\providecommand{\qedsymbol}{\textcolor{maincolor}{$\square$}}
\newcommand{\qed}{\hfill\text{\qedsymbol}}
\newenvironment{proof}{%
  \trivlist
  \newif\if@qed@set% prevent \qed from being called twice in one proof
  \renewcommand{\qed}{\if@qed@set\else\hfill\text{\qedsymbol}\fi\global\@qed@settrue}
  \item[\hskip\labelsep
        \upshape\bfseries\sffamily
    \textcolor{maincolor}{\proofname}\quad]\ignorespaces
}{\qed\endtrivlist}

% special claim environment
\newenvironment{claim}{%
  \trivlist
  \item[\hskip\labelsep
        \itshape
    \claimname\quad]\ignorespaces
}{\endtrivlist}
