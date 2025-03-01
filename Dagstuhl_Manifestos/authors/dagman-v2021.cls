%%
%% This is file `dagman-v2021.cls'.
%%
%% -----------------------------------------------------------------
%% Author:     Dagstuhl Publishing & le-tex publishing services
%%
%% This file is part of the dagman package for preparing
%% manifestos for the "Dagstuhl Manifestos" journal.
%%
%% Copyright (C) 2018 Schloss Dagstuhl
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is
%% Schloss Dagstuhl (publishing@dagstuhl.de).
%% -----------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{dagman-v2021}
    [2021/03/18 v3.0.0 Dagstuhl Manifestos articles]
\emergencystretch1em
\advance\hoffset-1in
\advance\voffset-1in
\advance\hoffset2.95mm
\newif\if@nobotseplist  \@nobotseplistfalse
\def\@endparenv{%
  \addpenalty\@endparpenalty\if@nobotseplist\else\addvspace\@topsepadd\fi\@endpetrue}
\def\@doendpe{%
  \@endpetrue
  \def\par{\@restorepar
           \everypar{}%
           \par
           \if@nobotseplist
             \addvspace\topsep
             \addvspace\partopsep
             \global\@nobotseplistfalse
           \fi
           \@endpefalse}%
  \everypar{{\setbox\z@\lastbox}%
            \everypar{}%
            \if@nobotseplist\global\@nobotseplistfalse\fi
            \@endpefalse}}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \expandafter
    \list
      \csname label\@enumctr\endcsname
      {\advance\partopsep\topsep
       \topsep\z@\@plus\p@
       \ifnum\@listdepth=\@ne
         \labelsep0.72em
       \else
         \ifnum\@listdepth=\tw@
           \labelsep0.3em
         \else
           \labelsep0.5em
         \fi
       \fi
       \usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}}%
  \fi}
\def\endenumerate{\ifnum\@listdepth=\@ne\global\@nobotseplisttrue\fi\endlist}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\advance\partopsep\topsep
       \topsep\z@\@plus\p@
       \ifnum\@listdepth=\@ne
         \labelsep0.83em
       \else
         \ifnum\@listdepth=\tw@
           \labelsep0.75em
         \else
           \labelsep0.5em
         \fi
      \fi
      \def\makelabel##1{\hss\llap{##1}}}%
  \fi}
\def\enditemize{\ifnum\@listdepth=\@ne\global\@nobotseplisttrue\fi\endlist}
\def\authorstotoc#1{%
  \@ifundefined{r@#1}%
    \relax
    {\space\texorpdfstring{\newline}{}\mdseries\itshape\nameref{#1}}}%\space for PDF-Bookmark
\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\ifnum#2=1\relax\let\sec@level1\fi
     \@ssect{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax
          \ifnum #2=1
            \colorbox[rgb]{0.99,0.78,0.07}{\kern0.15em\@svsec\kern0.15em}\quad
          \else
            \@svsec\quad
          \fi}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
      \ifx\@sectionnottotoc\@undefined
        \ifx\abstractsubsection\relax
          \addcontentsline{toc}{#1}{#7\authorstotoc{absaut\theabsaut}}%
          \let\abstractsubsection\@undefined
        \else%the executive-summary case (with \c@absaut=0):
          \addcontentsline{toc}{#1}{#7\ifx\nosectionauthors\@undefined\authorstotoc{absaut\theabsaut}\fi}%
        \fi
      \else
        \addbookmarkline{toc}{#1}{#7}%
        \let\@sectionnottotoc\@undefined
      \fi
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \ifx\@sectionnottotoc\@undefined
        \ifx\abstractsubsection\relax
          \addcontentsline{toc}{#1}{#7\authorstotoc{absaut\theabsaut}}%
          \let\abstractsubsection\@undefined
        \else
          \addcontentsline{toc}{#1}{#7}%
        \fi
      \else
        \addbookmarkline{toc}{#1}{#7}%
        \let\@sectionnottotoc\@undefined
      \fi}%
  \fi
  \@xsect{#5}}
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
        \@hangfrom{\hskip #1\relax
          \ifx\sec@level1\relax
            \colorbox[rgb]{0.99,0.78,0.07}{\kern0.15em\phantom{0}\kern0.15em}\quad
          \fi}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \ifx\sec@level1
    \let\sec@level\@undefined
    \ifx\@ssectionnottotoc\@undefined
      \addcontentsline{toc}{section}{#5\ifx\nosectionauthors\@undefined\authorstotoc{absaut\theabsaut}\fi}%
    \fi
  \fi
  \@xsect{#3}}
\def\@seccntformat#1{\csname the#1\endcsname}
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip 1ex\@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}
\def\@biblabel#1{\textcolor{darkgray}{\sffamily\bfseries#1}}
\def\copyrightline{%
  \scriptsize
  \vtop{\hsize\textwidth
    \@rightskip\@flushglue\rightskip\@rightskip
    \nobreakspace\\
    \setbox\@tempboxa\hbox{\includegraphics[height=14\p@,clip]{cc-by}}%
    \hspace*{\wd\@tempboxa}\enskip
    Except where otherwise noted, content of this manifesto is licensed\\
    \href{https://creativecommons.org/licenses/by/4.0/}%
         {\smash{\unhbox\@tempboxa}}\enskip under a
    \href{https://creativecommons.org/licenses/by/4.0/}
         {Creative Commons BY 4.0 International} license\\
    \ifx\@Event\@empty\else\@Event,\space\fi
    \textit{Dagstuhl~Manifestos},%
    \ifx\@Volume\@empty\else\space Vol.\nobreakspace\@Volume,\fi
    \ifx\@Issue\@empty\else\space Issue\nobreakspace\@Issue,\fi
    \space pp. \thepage--\number\numexpr\getpagerefnumber{TotPages}\\
    \ifx\@Editors\@empty\else
      \@Eds: \@Editors
      \\
    \fi
    \setbox\@tempboxa\hbox{\includegraphics[height=14\p@,trim=0 15 0 0]{dagman-logo-bw}}%
    \hspace*{\wd\@tempboxa}\enskip
    \href{https://www.dagstuhl.de/dagman/}%
         {Dagstuhl Manifestos}\\
    \smash{\unhbox\@tempboxa}\enskip
    \href{https://www.dagstuhl.de}%
         {Schloss Dagstuhl -- Leibniz-Zentrum f{\"u}r Informatik, Dagstuhl Publishing, Germany}}}
\def\ps@plain{\let\@mkboth\@gobbletwo
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \let\@evenfoot\copyrightline
  \let\@oddfoot\copyrightline}
\def\dagman@opterrshort{Option  "\CurrentOption" not supported}
\def\dagman@opterrlong{The option "\CurrentOption" from article.cls is not supported by dagman.cls.}
\DeclareOption{a5paper}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{b5paper}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{legalpaper}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{executivepaper}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{landscape}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{10pt}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{11pt}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{12pt}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{oneside}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{twoside}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{titlepage}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{notitlepage}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{onecolumn}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{twocolumn}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{fleqn}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{openbib}{\@latexerr{\dagman@opterrshort}{\dagman@opterrlong}}
\DeclareOption{pdfa}{\let\pdfa\relax}
\DeclareOption{a4paper}{\PassOptionsToClass{\CurrentOption}{article}
                        \advance\hoffset-2.95mm
                        \advance\voffset8.8mm}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[twoside,notitlepage,fleqn]{article}
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt{13}%
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\renewcommand\small{%
   \@setfontsize\small\@ixpt{11.5}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize{8.5}{9.5}%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\large{\@setfontsize\large{10.5}{13}}
\renewcommand\Large{\@setfontsize\Large{12}{14}}
\setlength\parindent{1.5em}
\setlength\headheight{3mm}
\setlength\headsep   {10mm}
\setlength\footskip{3mm}
\setlength\textwidth{140mm}
\setlength\textheight{222mm}
\setlength\oddsidemargin{32mm}
\setlength\evensidemargin{38mm}
\setlength\marginparwidth{25mm}
\setlength\topmargin{13mm}
\setlength{\skip\footins}{2\baselineskip \@plus 4\p@ \@minus 2\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep\z@ \@plus\p@
            \topsep 8\p@ \@plus2\p@ \@minus4\p@
            \itemsep \parsep}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    4\p@ \@plus2\p@ \@minus\p@
              \parsep\z@ \@plus\p@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    2\p@ \@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \z@ \@plus\p@}
\def\ps@headings{%
    \def\@evenhead{\large\sffamily\bfseries
                   \llap{\hbox to0.5\oddsidemargin{\thepage\hss}}\leftmark\hfil}%
    \def\@oddhead{\large\sffamily\bfseries\rightmark\hfil
                  \rlap{\hbox to0.5\oddsidemargin{\hss\thepage}}}%
    \def\@oddfoot{\hfil
                  \rlap{%
                    \vtop{%
                      \vskip10mm
                      \colorbox[rgb]{0.99,0.78,0.07}
                                    {\@tempdima\evensidemargin
                                     \advance\@tempdima1in
                                     \advance\@tempdima\hoffset
                                     \hb@xt@\@tempdima{%
                                       \textcolor{darkgray}{\normalsize\sffamily
                                       \bfseries\quad
                                       \expandafter\textsolittle
                                       \expandafter{\@seminarnumber}}%
                                     \strut\hss}}}}}
    \let\@evenfoot\@empty
    \let\@mkboth\markboth
  \let\sectionmark\@gobble
  \let\subsectionmark\@gobble}
\pagestyle{headings}
\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null\vskip-\baselineskip
  \vskip-\headsep
  \@titlerunning
  \@authorrunning
  \let \footnote \thanks
  \parindent\z@ \raggedright
    {\large\sffamily\@subject \par}%
    {\LARGE\sffamily\mathversion{bold}\@title \par}%
    \vskip 1.2em%
    \ifnum\c@authors=0 %
      \@latexerr{No \noexpand\author given}%
        {Provide at least one author. See the Dagstuhl Manifestos class documentation.}%
    \else
      %{\fontsize{9.5}{12}\bfseries Edited by\vskip0.5ex}%
      \@author
    \fi
  \par}
\setcounter{tocdepth}{2}
\AtBeginDocument{%
  \addtocontents{toc}{\let\string\@secpagenumber\relax}}
\renewcommand\tableofcontents{%
  \clearpage
  \let\@ssectionnottotoc\relax
  \let\nosectionauthors\relax
  \addtocontents{toc}{\let\string\@secpagenumber\string\@undefined}%
  \section*{\contentsname}%
  \currentpdfbookmark{\contentsname}{toc}%
  \@starttoc{toc}%
  \let\@ssectionnottotoc\relax
  \addtocontents{toc}{\let\string\@secpagenumber\string\relax}%
  \clearpage}
\renewcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak
      \ifx\@secpagenumber\relax
        \normalfont \normalcolor
        \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern\@dotsep mu$}\hfill
        \nobreak\hb@xt@\@pnumwidth{\hss#2}%
      \else
        \hfil\null
      \fi
      \par
    \endgroup
  \fi}
\renewcommand*\l@subsection{\@dottedtocline{2}{1.5em}{\z@}}
\setcounter{secnumdepth}{4}
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-7.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\sffamily\Large\bfseries\raggedright}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-7.5ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\sffamily\Large\bfseries\raggedright}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\sffamily\large\bfseries\raggedright}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {-3.25ex \@plus-1ex \@minus-.2ex}%
                                    {1.5ex \@plus .2ex}%
                                    {\sffamily\normalsize\bfseries\raggedright}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\z@}%
                                       {1.5ex \@plus .2ex}%
                                       {-1em}%
                                      {\sffamily\normalsize\bfseries}}
\setlength\leftmargini  \parindent
\setlength\leftmarginii {1.2em}
\setlength\leftmarginiii{1.2em}
\setlength\leftmarginiv {1.2em}
\setlength\leftmarginv  {1.2em}
\setlength\leftmarginvi {1.2em}
\renewcommand\labelenumi{%
  \textcolor{darkgray}{\sffamily\mathversion{bold}\theenumi.}}
\renewcommand\labelenumii{%
  \textcolor{darkgray}{\sffamily\mathversion{bold}\theenumii.}}
\renewcommand\labelenumiii{%
  \textcolor{darkgray}{\sffamily\mathversion{bold}\theenumiii.}}
\renewcommand\labelenumiv{%
  \textcolor{darkgray}{\sffamily\mathversion{bold}\theenumiv.}}
\renewcommand\labelitemi{%
  \textcolor[rgb]{0.6,0.6,0.61}{\ifnum\@listdepth=\@ne
                                  \rule{0.67em}{0.33em}%
                                \else
                                  \rule{0.45em}{0.225em}%
                                \fi}}
\renewcommand\labelitemii{%
  \textcolor[rgb]{0.6,0.6,0.61}{\rule{0.45em}{0.225em}}}
\renewcommand\labelitemiii{%
  \textcolor[rgb]{0.6,0.6,0.61}{\sffamily\bfseries\textasteriskcentered}}
\renewcommand\labelitemiv{%
  \textcolor[rgb]{0.6,0.6,0.61}{\sffamily\bfseries\textperiodcentered}}
\renewenvironment{description}
               {\list{}{\advance\partopsep\topsep\topsep\z@\@plus\p@
                        \labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\ifnum\@listdepth=\@ne\global\@nobotseplisttrue\fi\endlist}
\renewcommand*\descriptionlabel[1]{%
  \hspace\labelsep\textcolor{darkgray}{\sffamily\bfseries\mathversion{bold}#1}}
\renewenvironment{abstract}{%
%  \vskip0.1\bigskipamount
  \noindent
  \rlap{\color[rgb]{0.51,0.50,0.52}\vrule\@width\textwidth\@height1\p@}%
  \hspace*{7mm}\fboxsep1.5mm\colorbox[rgb]{1,1,1}{\raisebox{-0.4ex}{%
    \large\selectfont\sffamily\bfseries\abstractname}}%
  \vskip1\p@
  \fontsize{9.5}{12}\selectfont
  \noindent\ignorespaces}
  {\par
   \vskip0.2\baselineskip
   \ifx\@semdata\@empty\else
     \noindent\hangindent\parindent
     \semdataHeading\@semdata\par
   \fi
     \noindent\hangindent\parindent
     \subjclassHeading\ifx\@ccsdescString\@empty%
     \textcolor{red}{Author: Please fill in 1 or more \string\ccsdesc\space macro}%
   \else%
     \@ccsdescString
   \fi\par
   \ifx\@keywords\@empty\else
     \noindent\hangindent\parindent
     \keywordsHeading\@keywords\par
   \fi
   \ifx\@DOI\@empty\else
     \noindent\hangindent\parindent
     \doiHeading\href{https://doi.org/\@DOI}{\@DOI}\par%
   \fi
   \ifx\@additionaleditors\@empty\else
     \noindent
     \additionaleditorsHeading\@additionaleditors\hangindent\parindent\par
   \fi
   \ifx\@funding\@empty\else
     \noindent\hangindent\parindent
     \fundingHeading\@funding\par
   \fi
   \ifx\@acknowledgements\@empty\else
     \noindent\hangindent\parindent
     \acknowledgementsHeading\@acknowledgements\par
   \fi
}
\renewenvironment{thebibliography}[1]
  {\if@noskipsec \leavevmode \fi
   \par
   \@tempskipa-3.5ex \@plus -1ex \@minus -.2ex\relax
   \@afterindenttrue
   \@tempskipa -\@tempskipa \@afterindentfalse
   \if@nobreak
     \everypar{}%
   \else
     \addpenalty\@secpenalty\addvspace\@tempskipa
   \fi
   \noindent
   \rlap{\color[rgb]{0.51,0.50,0.52}\vrule\@width\textwidth\@height1\p@}%
   \hspace*{7mm}\fboxsep1.5mm\colorbox[rgb]{1,1,1}{\raisebox{-0.4ex}{%
     \normalsize\sffamily\bfseries\refname}}%
   \@xsect{1ex \@plus.2ex}%
   \addcontentsline{toc}{section}{\refname}%
   %\let\@ssectionnottotoc\@undefined
   %\section*{\refname}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\leftmargin8.5mm
         \labelsep\leftmargin
         \settowidth\labelwidth{\@biblabel{#1}}%
         \advance\labelsep-\labelwidth
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \fontsize{9.5}{12.5}\selectfont
   \sloppy
   \clubpenalty4000
   \@clubpenalty \clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr
     {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}
\renewcommand\footnoterule{%
  \kern-8\p@
  {\color[rgb]{0.60,0.60,0.61}\hrule\@width40mm\@height1\p@}%
  \kern6.6\p@}
\renewcommand\@makefntext[1]{%
    \parindent\z@\hangindent1em
    \leavevmode
    \hb@xt@1em{\@makefnmark\hss}#1}
\raggedbottom
\usepackage[utf8]{inputenc}
\IfFileExists{glyphtounicode.tex}{
\input glyphtounicode
\pdfgentounicode=1
}{}%
\IfFileExists{lmodern.sty}{\RequirePackage{lmodern}}{}
\IfFileExists{fontawesome5.sty}{%
\RequirePackage{fontawesome5}%
\IfFileExists{orcid.pdf}{%
\def\orcidsymbol{\includegraphics[height=9\p@]{orcid}}
}{
\def\orcidsymbol{\textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries \faOrcid}}%
}
}{%
\ClassWarning{Package fontawesome5 not installed}{Please install package fontawesome5}
\def\orcidsymbol{\textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries ORCID}}
}%
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage[mathscr]{eucal}
\RequirePackage{amssymb}
\RequirePackage{soul}
\sodef\textsolittle{}{.12em}{.5em\@plus.08em\@minus.06em}%
        {.4em\@plus.275em\@minus.183em}
\RequirePackage{color}
\definecolor{darkgray}{rgb}{0.31,0.31,0.33}
\RequirePackage{babel}
\addto\captionsUKenglish{\renewcommand\contentsname{Table of Contents}}
\addto\captionsUSenglish{\renewcommand\contentsname{Table of Contents}}
\RequirePackage[tbtags,fleqn]{amsmath}
\RequirePackage{amsthm}
\thm@headfont{%
  \textcolor{darkgray}{$\blacktriangleright$}\nobreakspace\sffamily\bfseries}
\def\th@remark{%
  \thm@headfont{%
    \textcolor{darkgray}{$\blacktriangleright$}\nobreakspace\sffamily}%
  \normalfont % body font
  \thm@preskip\topsep \divide\thm@preskip\tw@
  \thm@postskip\thm@preskip
}
\def\@endtheorem{\endtrivlist}%\@endpefalse
\renewcommand\qedsymbol{\textcolor{darkgray}{\ensuremath{\blacktriangleleft}}}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \color{darkgray}\sffamily\bfseries
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist%\@endpefalse
}
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\theoremstyle{remark}
\newtheorem*{remark}{Remark}
\@addtoreset{theorem}{subsection}
\RequirePackage{graphicx}
\RequirePackage{array}
\let\@classzold\@classz
\def\@classz{%
   \expandafter\ifx\d@llarbegin\begingroup
     \toks \count@ =
     \expandafter{\expandafter\small\the\toks\count@}%
   \fi
   \@classzold}
\RequirePackage{multirow}
\RequirePackage{tabularx}
\RequirePackage[online]{threeparttable}
\def\TPTtagStyle#1{#1)}
\def\tablenotes{\small\TPT@defaults
  \@ifnextchar[\TPT@setuptnotes\TPTdoTablenotes} % ]
\RequirePackage{listings}
\lstset{basicstyle=\small\ttfamily,%
        backgroundcolor=\color[rgb]{0.85,0.85,0.86},%
        frame=single,framerule=0pt,xleftmargin=\fboxsep,xrightmargin=\fboxsep}
\let\usehyperxmp\@empty%
\ifx\pdfa\relax%
  \IfFileExists{hyperxmp.sty}{%
    \RequirePackage{hyperxmp}%
    \@ifpackagelater{hyperxmp}{2019/04/05}{%
      \let\usehyperxmp\relax%
    }{%
      \ClassWarning{Package hyperxmp outdated}{You are using an outdated version of the package hyperxmp. Please update!}%
    }}{}%
\fi%
\IfFileExists{totpages.sty}{
  \RequirePackage{totpages}
}{
	\ClassWarning{Package totpages not installed}{Please install package totpages}
	\newcounter{TotPages}
	\setcounter{TotPages}{99}
}
\ifx\usehyperxmp\relax%
  \RequirePackage[pdfa,unicode]{hyperref}%
\else%
  \RequirePackage[unicode]{hyperref}%
\fi%
\let\C\relax%
\let\G\relax%
\let\F\relax%
\let\U\relax%
\pdfstringdefDisableCommands{%
	\let\thanks\@gobble%
	\let\footnote\@gobble%
	\def\footnotemark{}%
	\def\cs#1{\textbackslash #1}%
	\let\normalfont\@empty%
	\let\scshape\@empty%
	\def\and{and }%
	\def\,{ }%
	\def\textrightarrow{ -> }%
	\let\mathsf\@empty%
}%
\hypersetup{
	breaklinks=true,
	pdfencoding=unicode,
	bookmarksnumbered,
	pdfborder={0 0 0},
	pdfauthor={ },
	pdftitle={ }
}%
\AtBeginDocument{
\ifx\usehyperxmp\relax
\hypersetup{
pdftitle={\@title},
pdfauthor={\@Editors},
pdfkeywords={\@keywords},
pdfproducer={LaTeX with dagman-v2021.cls},
pdfsubject={Dagstuhl Manifestos, Vol. \@Volume, Issue \@Issue, Seminar \@Event},
pdfcopyright = { Copyright (C) \@Editors; licensed under Creative Commons License CC-BY 4.0},
pdflang={en},
pdfmetalang={en},
pdfpublisher={Schloss Dagstuhl -- Leibniz-Zentrum für Informatik, Dagstuhl Publishing, Germany},
pdflicenseurl={https://creativecommons.org/licenses/by/4.0/},
pdfpubtype={Dagstuhl Reports},
pdfvolumenum={\@Volume},
pdfpagerange={\thepage-\theTotPages},
pdfdoi={\@DOI},
pdfapart=3,
pdfaconformance=B
}
\else%
\hypersetup{
pdftitle={\@title},
pdfauthor={\@Editors},
pdfkeywords={\@keywords},
pdfcreator={LaTeX with dagman-v2021.cls},
pdfsubject={Dagstuhl Manifestos, Vol. \@Volume, Issue \@Issue, Seminar \@Event; Copyright (C) \@Editors; licensed under Creative Commons License CC-BY 4.0}
}%
\fi	%
}
\ifx\usehyperxmp\relax
\pdfobjcompresslevel=0
\pdfinclusioncopyfonts=1
\IfFileExists{colorprofiles.tex}{
\RequirePackage{colorprofiles}%
\IfFileExists{sRGB.icc}{
\immediate\pdfobj stream attr{/N 3} file{sRGB.icc}
\pdfcatalog{%
/OutputIntents [
<<
/Type /OutputIntent
/S /GTS_PDFA1
/DestOutputProfile \the\pdflastobj\space 0 R
/OutputConditionIdentifier (sRGB)
/Info (sRGB)
>>
]
}}{}
}{\ClassWarning{Package colorprofiles not installed}{Please install package colorprofiles}}
\fi
\RequirePackage[labelsep=space,singlelinecheck=false,%
  font={up,small},labelfont={sf,bf},%
  listof=false]{caption}%"listof" instead of "list" for backward compatibility
\@ifpackagelater{hyperref}{2009/12/09}
  {\captionsetup{compatibility=false}}%cf. http://groups.google.de/group/comp.text.tex/browse_thread/thread/db9310eb540fbbd8/42e30f3b7b3aa17a?lnk=raot
  {}
\DeclareCaptionLabelFormat{boxed}{%
  \kern0.05em{\color[rgb]{0.99,0.78,0.07}\rule{0.73em}{0.73em}}%
  \hspace*{0.67em}\bothIfFirst{#1}{~}#2}
\captionsetup{labelformat=boxed}
\captionsetup[table]{position=top}
\RequirePackage{subfig}
\def\titlerunning#1{\gdef\@titlerunning{{\let\footnote\@gobble\markboth{#1}{#1}}}}
\def\authorrunning#1{%
  \gdef\@authorrunning{\expandafter\def\expandafter\@tempa\expandafter{#1}%
                       \ifx\@tempa\@empty\else\markright{#1}\fi}}
\titlerunning{\@title}
\authorrunning{\AB@authrunning}
\newcommand*\volumeinfo[6]{%
  {\gdef\@Editors{#1}%
   \gdef\@Eds{Editor}\ifnum #2>1 \gdef\@Eds{Editors}\fi
   \gdef\@Event{#3}%
   \gdef\@Volume{#4}%
   \gdef\@Issue{#5}%
   \gdef\@FirstPage{#6}%
   \setcounter{page}{#6}}}
\volumeinfo{}{1}{}{}{}{1}
\def\and{\leavevmode\unskip\ignorespaces;\xspace}
\RequirePackage{authblk}
\renewcommand*\Authand{{ and }}
\renewcommand*\Authfont{\Large\bfseries\mathversion{bold}}
\renewcommand*\AB@authnote[1]{\textsuperscript{#1}}
\renewcommand*\AB@affilnote[1]{\protect\item[#1]}
\renewcommand*\Affilfont{\fontsize{9.5}{12}\selectfont}
\setlength\affilsep{0.8\baselineskip}
\newcommand\AB@authrunning{}
\newcommand\AB@authfortoc{}
\let\@showEditorFootnote\relax
\newcommand{\editor}[5]{
	\ifx\@showEditorFootnote\relax
		\author{#1\footnote{Editor\,/\,Organizer \protect\label{fn:editor}}}{#2}{#3}{#4}{#5}%
		\let\@showEditorFootnote\true%
	\else
		\author{#1\textsuperscript{\normalfont\ref{fn:editor}}}{#2}{#3}{#4}{#5}%
	\fi
}
\let\@showCollectorFootnote\relax
\newcommand{\collector}[5]{
	\ifx\@showCollectorFootnote\relax
		\author{#1\footnote{Editorial Assistant\,/\,Collector \protect\label{fn:collector}}}{#2}{#3}{#4}{#5}%
		\let\@showCollectorFootnote\true%
	\else
		\author{#1\textsuperscript{\normalfont\ref{fn:collector}}}{#2}{#3}{#4}{#5}%
	\fi
}
\def\funding#1{%
\ifx\@funding\@empty%
      \def\@funding{#1}%
    \else%
      \let\orig@funding\@funding
     \def\@funding{#1\\\orig@funding}%
    \fi%
}
\let\@funding\@empty
\usepackage{letltxmacro}
\newcommand*{\gobblemyopt}[2][]{\@bsphack\@esphack}
\renewcommand{\author}[5]{%
  \authorInternal{#1}%
  \affilInternal{#2}{#3}{#4}%
  \if!#5!\else%
    \ifx\@funding\@empty%
      \expandafter\g@addto@macro\expandafter\@funding{\textit{\expandafter{\let\footnote\gobblemyopt \let\footnotemark\gobblemyopt \let\textsuperscript\@gobble #1}}:\space{#5}}%
    \else%
      \expandafter\g@addto@macro\expandafter\@funding{\\\textit{\expandafter{\let\footnote\gobblemyopt \let\footnotemark\gobblemyopt \let\textsuperscript\@gobble #1}}:\space{#5}}%
    \fi%
  \fi%
}
\newcommand\authorInternal[2][]%
      {\ifnewaffil\addtocounter{affil}{1}%
       \edef\AB@thenote{\arabic{affil}}\fi
      \if\relax#1\relax\def\AB@note{\AB@thenote}\else\def\AB@note{#1}%
        \setcounter{Maxaffil}{0}\fi
      \ifnum\value{authors}>1\relax
      \@namedef{@sep\number\c@authors}{\Authsep}\fi
      \addtocounter{authors}{1}%
      \begingroup
          \let\protect\@unexpandable@protect \let\and\AB@pand
          \def\thanks{\protect\thanks}\def\footnote{\protect\footnote}\def\footnotemark{\protect\footnotemark}%
         \@temptokena=\expandafter{\AB@authors}%
         {\def\\{\protect\\[\@affilsep]\protect\Affilfont
              \protect\AB@resetsep}%
              \xdef\AB@author{\AB@blk@and#2}%
       \ifnewaffil\gdef\AB@las{}\gdef\AB@lasx{\protect\Authand}\gdef\AB@as{}%
           \xdef\AB@authors{\the\@temptokena\AB@blk@and}%
       \else
          \xdef\AB@authors{\the\@temptokena\AB@as\AB@au@str}%
          \global\let\AB@las\AB@lasx\gdef\AB@lasx{\protect\Authands}%
          \gdef\AB@as{\Authsep}%
       \fi
       \gdef\AB@au@str{#2}}%
         \@temptokena=\expandafter{\AB@authlist}%
         \let\\=\authorcr
         \xdef\AB@authlist{\the\@temptokena
           \protect\@nameuse{@sep\number\c@authors}%
           \protect\Authfont#2\AB@authnote{\AB@note}}%
         %new
         \@temptokena=\expandafter{\AB@authrunning}%
         \let\\=\authorcr
         \xdef\AB@authrunning{\the\@temptokena
           \protect\@nameuse{@sep\number\c@authors}#2}%
         %
         %new
         \@temptokena=\expandafter{\AB@authfortoc}%
         \let\\=\authorcr
         \xdef\AB@authfortoc{\the\@temptokena
           \expandafter\noexpand\csname @sep\number\c@authors\endcsname#2}%
         %
      \endgroup
      \ifnum\value{authors}>2\relax
      \@namedef{@sep\number\c@authors}{\Authands}\fi
      \newaffilfalse
}
\usepackage{xspace}
\newbox{\orcidbox}
\savebox{\orcidbox}{\orcidsymbol}
\newcommand{\orcid}[1]{%
  \href{#1}{\usebox{\orcidbox}}}
\newcommand\affilInternal[4][]%
   {\newaffiltrue\let\AB@blk@and\AB@pand
      \if\relax#1\relax\def\AB@note{\AB@thenote}\else\def\AB@note{#1}%
        \setcounter{Maxaffil}{0}\fi
      \begingroup
        \let\protect\@unexpandable@protect
        \def\thanks{\protect\thanks}\def\footnote{\protect\footnote}\def\footnotemark{\protect\footnotemark}%
        \@temptokena=\expandafter{\AB@authors}%
        {\def\\{\protect\\\protect\Affilfont}\xdef\AB@temp{#2}}%
         \xdef\AB@authors{\the\@temptokena\AB@las\AB@au@str
         \protect\\[\affilsep]\protect\Affilfont\AB@temp}%
         \gdef\AB@las{}\gdef\AB@au@str{}%
        {\xdef\AB@temp{\if\relax#4\else\orcid{#4}\,\,\fi#2\ignorespaces\if\relax#3\else\xspace. \href{mailto:#3}{\texttt{#3}}\fi}}%
        \@temptokena=\expandafter{\AB@affillist}%
        \xdef\AB@affillist{\the\@temptokena \AB@affilsep
          \AB@affilnote{\AB@note}\protect\Affilfont\AB@temp}%
      \endgroup
       \let\AB@affilsep\AB@affilsepx}
\renewcommand*\affil[2][]{%
  \ClassError{dagman}
    {\string\affil\space deprecated: Please enter affiliation as second parameter of the author macro}
    {Since 2021, \string\affil\space is obsolete in dagman.}}
\renewcommand\@author{\ifx\AB@affillist\AB@empty\AB@authrunning\else
      \ifnum\value{affil}>\value{Maxaffil}\def\rlap##1{##1}%
    \AB@authlist\\[\affilsep]
    \labelwidth1.5em\labelsep\z@\leftmargini\labelwidth
    \edef\@enumctr{enumi}%
    \list\theenumi{\usecounter\@enumctr\def\makelabel##1{\rlap{##1}\hss}}%
      \AB@affillist
    \endlist
    \else  \AB@authors\fi\fi}
\RequirePackage{comment}
\excludecomment{CCSXML}
% inspired by https://tex.stackexchange.com/questions/12810/how-do-i-split-a-string
\global\newcommand\ccsdesc[2][100]{\@ccsdesc#1~#2~~\relax}
\let\orig@ccsdesc\@ccsdesc
\let\@ccsdesc\@empty
\let\@ccsdescString\@empty
\gdef\@ccsdesc#1~#2~#3~{
	\ifx\@ccsdesc\orig@ccsdesc\let\@ccsdesc\@empty\fi
	\ifx!#3!
		\ifx\@ccsdescString\@empty
			\g@addto@macro\@ccsdescString{{#2}}
		\else
			\g@addto@macro\@ccsdescString{; {#2}}
		\fi
	\else
		\ifx\@ccsdescString\@empty
			\g@addto@macro\@ccsdescString{{#2} $\rightarrow$ {#3}}
		\else
			\g@addto@macro\@ccsdescString{; {#2} $\rightarrow$ {#3}}
		\fi
	\fi
\ccsdescEnd
}
\def\ccsdescEnd#1\relax{}
\def\subjclass#1{
  \ClassError{dagman}
    {\string\subjclass\space deprecated: Please enter subject classification in 1 or more ccsdesc macros}
    {Since 2021, \string\subjclass\space is obsolete in dagman.}}
\let\@subjclass\@empty
\def\keywords#1{\def\@keywords{#1}}
\let\@keywords\@empty
\def\keywordsHeading{%
  \textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries
                       Keywords and phrases\enskip}}
\def\subjclassHeading{%
  \textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries
                       2012 ACM Subject Classification\enskip}}
\def\doiHeading{%
  \textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries
                       Digital Object Identifier\enskip}}
\def\fundingHeading{%
  \textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries
                      Funding\enskip}}
\def\acknowledgements#1{\def\@acknowledgements{#1}}
\let\@acknowledgements\@empty
\def\acknowledgementsHeading{%
  \textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries
                      Acknowledgements\enskip}}
\def\subject#1{\gdef\@subject{#1}}
\subject{}
\def\seminarnumber#1{\gdef\@seminarnumber{#1}}
\seminarnumber{}
\def\semdata#1{\gdef\@semdata{#1}}
\semdata{}
\def\semdataHeading{%
  \textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries
                       Perspectives Workshop\enskip}}
\def\DOI#1{\gdef\@DOI{#1}}
\def\DOIPrefix#1{\gdef\@DOIPrefix{#1}}
\DOIPrefix{10.4230/DagMan}
\DOI{\@DOIPrefix.\@Volume.\@Issue.\@FirstPage}
\def\additionaleditors#1{\gdef\@additionaleditors{#1}}
\additionaleditors{}
\def\additionaleditorsHeading{%
  \textcolor{darkgray}{\fontsize{9.5}{12}\sffamily\bfseries
                       Edited in cooperation with\enskip}}
\newcommand*\summaryauthor{\@dblarg{\@summaryauthor}}
\def\@summaryauthor[#1]#2{%
  \textit{#2}\@@par
  \protected@write\@auxout{}{%
    \string\newlabel{absaut\theabsaut}{{0}{\thepage}{#1}{\@currentHref}{}}}%
  \@xsect{2.3ex \@plus.2ex}}
\def\abstracttitle{%
  \let\abstractsubsection\relax
  \let\@abstractpreamble\@undefined
  \refstepcounter{absaut}%
  \subsection}
\newcounter{absaut}
\newcommand*\abstractauthor{\@abstractauthor}
\let\@authorblock\@empty
\let\@licensestring\@empty
\newcommand{\@abstractauthor}[4]{%
	\ifx\@authorblock\@empty%
      \expandafter\g@addto@macro\expandafter\@authorblock{\textit{#1}\xspace(\if\relax#4\else\orcid{#4}\,\,\fi\textit{#2}\ignorespaces\if\relax#3\else\xspace. \href{mailto:#3}{\texttt{#3}}\fi)}%
    \else%
      \expandafter\g@addto@macro\expandafter\@authorblock{;\xspace\textit{#1} (\if\relax#4\else\orcid{#4}\,\,\fi#2\ignorespaces\if\relax#3\else\xspace. \href{mailto:#3}{\texttt{#3}}\fi)}%
    \fi%
	\ifx\@licensestring\@empty%
      \expandafter\g@addto@macro\expandafter\@licensestring{\textit{#1}}%
    \else%
      \expandafter\g@addto@macro\expandafter\@licensestring{;\xspace\textit{#1}}%
    \fi%

}
\def\@preambleentryheading#1{\scriptsize\sffamily\bfseries#1\enskip}
\long\def\@preambleentry#1#2{%
  \ifx\@abstractpreamble\@undefined\let\@abstractpreamble\relax\else\vskip-\lastskip\fi
  \@noskipsecfalse
  \bgroup
    \parindent\z@
    \setbox\@tempboxa\hbox{\@preambleentryheading{Main reference}}%
    \leftskip\wd\@tempboxa
    \@rightskip\@flushglue\rightskip\@rightskip
    \leavevmode\llap
    {\@preambleentryheading{#1}}\@setfontsize\scriptsize{7.5}{8.5}#2\par
    \nobreak
  \egroup
  \vskip2.3ex \@plus.2ex\@minus\z@
  \@afterheading}
\newcommand*\jointwork[1]{\@preambleentry{Joint work of}{#1}}
\newcommand\license{
  \@authorblock\par\@xsect{2.3ex \@plus.2ex}%%
  \protected@write\@auxout{}{%
    \string\newlabel{absaut\theabsaut}{{\theabsaut}{\thepage}{\@licensestring}{\@currentHref}{}}}%
  \@preambleentry{License}{%
  \href{https://creativecommons.org/licenses/by/4.0/}%
       {\raise-2\p@\hb@xt@1.45em{% 4.2
          \includegraphics[height=7.5\p@,clip]{cc}\enskip\hfil}}%
  \href{https://creativecommons.org/licenses/by/4.0/}
               {Creative Commons BY 4.0 International} license\newline
  \null\hb@xt@1.45em{\hfil\textsf{\textcopyright}\hfil\enskip}\nameref{absaut\theabsaut}}
  \let\@authorblock\@empty
  \let\@licensestring\@empty
}
\newcommand*\abstractref{\@dblarg{\@abstractref}}
\def\@abstractref[#1]#2{\@preambleentry{Main reference}{\href{#1}{#2}}}
\newcommand*\abstractrefurl[1]{\@preambleentry{URL}{\href{#1}{#1}}}
\RequirePackage{multicol}
\newif\if@firstparticipant
\newenvironment{participants}
 {\clearpage
  %\def\thesection{%
  %  \vrule\@width\z@\@height0.65em\@depth\z@
  %  \vrule\@width0.65em\@height\z@\@depth\z@}%
  \addtocontents{toc}{\let\string\@secpagenumber\relax}%
  \section{Participants}%
  \footnotesize
  \global\@firstparticipanttrue
  \parindent=\z@
  \hyphenpenalty=\@M
  \raggedright
  \interlinepenalty=\@M
  \begin{multicols}{3}}
 {\end{multicols}}
\def\participant{%
  \if@firstparticipant
    \global\@firstparticipantfalse
    \def\\{\hfil\penalty-\@M}%
  \else
    \par
    \addvspace{\smallskipamount}%
  \fi
  \labelitemi\hskip\labelsep}
\endinput
%%
%% End of file `dagman-v2018.cls'.
