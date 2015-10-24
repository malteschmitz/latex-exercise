\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uebungsblatt}

% Eingabekodierung
\RequirePackage[utf8]{inputenc}

% neues Deutsch
\RequirePackage[ngerman]{babel}

% Schriftart
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

% KOMA-Script Klasse Article
\LoadClass{scrartcl}
\KOMAoption{paper}{a4}
\KOMAoption{pagesize}{automedia}
\KOMAoption{fontsize}{10pt}
\KOMAoption{headinclude}{true}
\KOMAoption{footinclude}{false}
\KOMAoption{parskip}{half}

% Überschriften
\RequirePackage{scrpage2}
\KOMAoption{headings}{normal}
\setcounter{secnumdepth}{0}

% Farben
\RequirePackage{color}
\definecolor{lightgray}{gray}{0.5}
\definecolor{darkblue}{rgb}{0,0,0.3}
\definecolor{darkred}{rgb}{0.5,0,0}
\definecolor{lightyellow}{rgb}{1,1,0.8}
\definecolor{darkyellow}{rgb}{0.89,0.59,0}

% Kopf- und Fußzeile (Inhalt)
\pagestyle{scrheadings}
\automark{section}
\newcommand{\gruppe}[1]{\ihead{\sffamily Gruppe #1}}
\newcommand{\uebung}[2]{ \chead{ {\large \bfseries #1} \vspace{3pt} \\ {\large #2}} }
\newcommand{\studenten}[1]{\ohead{\textit{ \small \sffamily #1}}}
\RequirePackage{lastpage}
\cfoot{Seite \thepage{} von \pageref*{LastPage}}

% Kopf- und Fußzeile (Layout)
\setheadtopline{3pt}[\color{lightgray}]
\setheadsepline{0.2pt}
\setkomafont{pageheadfoot}{\normalfont}
\setkomafont{pagefoot}{\normalfont \small \sffamily}
\KOMAoption{headlines}{4}

% Satzspiegel berechnen
\KOMAoption{DIV}{12}

% PDF Hyperlink-Spezialitäten
\RequirePackage[colorlinks=true, breaklinks=true]{hyperref}

% Anführungszeichen
\RequirePackage[babel,german=quotes]{csquotes}

% Mathe
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\mathtoolsset{showonlyrefs} % Nummerierung nur bei Referenzierung

% Vektoren formatieren
\renewcommand{\vec}[1]{\boldsymbol{#1}} % Vektoren fett
% \renewcommand{\vec}[1]{\underline{#1}} % Vektoren unterstreichen

% Bilder
\RequirePackage{graphicx}

% Häkchen
\newcommand{\tick}{\checkmark}

% tollere Listen
\RequirePackage{paralist}

% Quelltexte darstellen
\RequirePackage{listings}
\lstset{inputencoding=utf8, extendedchars=\true}
\lstset{language=Java} % Java
\newcommand{\quelltext}[2]{
  \minisec{Quelltext der Klasse \texttt{#1}}
  \lstinputlisting{#2}
}

\newcommand{\formel}[1]{$\color{darkblue}#1$}

\newcommand{\name}[1]{{\bfseries \sffamily \color{red} #1}}

\newcommand{\kommentar}[1]{\textcolor{darkred}{(#1)}}

\newcommand{\axiom}[1]{\textcolor{darkyellow}{$\boldsymbol{(}$}\textcolor{darkred}{\textbf{#1}}\textcolor{darkyellow}{$\boldsymbol{)}$}}

\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\K}{\mathbb{K}}
\newcommand{\Q}{\mathbb{Q}}

\newcommand{\inhead}[1]{\begin{sffamily}\bfseries #1 \end{sffamily}}

\RequirePackage{ulsy}
\newcommand{\blitz}{\quad\text{\blitze}}