%%
%% preprint.cls - manuscript class for scientific preprints,
%% with switchable preprint / journal-submission layouts.
%%

\typeout{Document Class `preprint'.}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{preprint}[2026/01/01 v1.0 manuscript class]

% \AtEndOfClass{\RequirePackage{microtype}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions*
%% Load base class
\LoadClass{extarticle}

%% define new needed boolean variables
\newif\if@tmptwocolumn  \@tmptwocolumnfalse
\newif\if@times         \@timesfalse
\newif\if@helvet         \@helvetfalse
\newif\if@submit        \@submitfalse

%% Options
\newif\ifbfabstract     \bfabstracttrue
\DeclareOption{rmabstract}{\bfabstractfalse}
\newif\ifbibskip        \bibskipfalse
\DeclareOption{bibskip}{\bibskiptrue}
\newif\ifwatermark        \watermarkfalse
\DeclareOption{watermark}{\watermarktrue}
\newif\if@plainmarks      \@plainmarksfalse
\DeclareOption{plainmarks}{\@plainmarkstrue}  % conventional *, dagger marks
\newif\if@footauthor      \@footauthortrue
\DeclareOption{nofootauthor}{\@footauthorfalse}     % drop author from left footer
\newif\if@firstfootlogo   \@firstfootlogofalse
\DeclareOption{firstfootlogo}{\@firstfootlogotrue}  % logo in title-page right footer

\DeclareOption{draft}{\PassOptionsToClass{draft}{article}}
\DeclareOption{times}{\@timestrue}
\DeclareOption{helvet}{\@helvettrue}
\DeclareOption{twocolumn}{\@tmptwocolumntrue}
%\DeclareOption{onecolumn}{\@tmptwocolumnfalse}
\DeclareOption{submit}{\@submittrue \@tmptwocolumnfalse}

\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package dependencies - Start %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{amsmath,amsfonts}
\RequirePackage{XCharter}   % Charter: a clean, modern journal serif (body text)
\RequirePackage{xcolor}
\RequirePackage{authblk}
\RequirePackage[latin1,utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage{lmodern}
\RequirePackage[detect-all=true]{siunitx}
\RequirePackage{textgreek}
% for no hyphenation add [none] option
\if@submit
  \usepackage[none]{hyphenat}
\else
  \usepackage{hyphenat}
\fi
% reduce the spacing after a full-stop
%\frenchspacing
% this line causes a l3regex obsolete warning - problem seems Overleaf-side
\RequirePackage[version=4]{mhchem}
%% Units
\DeclareSIUnit\molar{\mole\per\cubic\deci\metre}
\DeclareSIUnit\Molar{\textsc{m}}
\DeclareSIUnit\gee{\textit{g}}
\DeclareSIUnit\Units{\textnormal{U}}
\DeclareSIUnit\rpm{\textnormal{rpm}}
\DeclareSIUnit\pixel{\textnormal{px}}
\DeclareSIUnit\electron{\textnormal{e\textsuperscript{--}}}

\RequirePackage[scaled]{helvet}
\RequirePackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\RequirePackage{lettrine} % For dropped capitals
\RequirePackage[rightcaption]{sidecap} % For sidecaptions
%\sidecaptionvpos{figure}{t}
\RequirePackage[misc]{ifsym} % For the \Letter symbol
\RequirePackage{bbding} % For the \Envelope symbol
\RequirePackage[a4paper,
                total={170mm,247mm},
                left=20mm,
                top=25mm]{geometry}
\RequirePackage[labelfont={bf,sf},%
                labelsep=period,%
                figurename=Figure]{caption}

%% line numbers
\if@submit
  \RequirePackage{lineno}
  \linenumbers
\fi

%% Hyperlinking
\RequirePackage[colorlinks=true, allcolors=blue]{hyperref}

%% Toolkit packages (math / theorems / tables / boxes / symbols).
%% These are loaded but do not alter the default visual layout; the macros
%% and environments they enable are opt-in (see the Toolkit block below).
\RequirePackage{mathtools}        % extends amsmath
\RequirePackage{bm}               % bold math symbols
\RequirePackage{amsthm}           % theorem environments
\RequirePackage{booktabs}         % \toprule \midrule \bottomrule
\RequirePackage{makecell}         % multi-line table cells
\RequirePackage{tabularx}         % auto-width X columns
\RequirePackage{ragged2e}         % \RaggedRight for Y columns
\RequirePackage{pifont}           % \ding check / cross marks
\RequirePackage[most]{tcolorbox}  % highlight boxes
\RequirePackage{multirow}         % multi-row table cells
\RequirePackage{threeparttable}   % tables with note blocks
\RequirePackage{algorithm}        % algorithm float wrapper
\RequirePackage{algpseudocode}    % algorithmic pseudocode
\RequirePackage[charter]{newtxmath}  % Charter-matched math; provides scalable \mathscr

%% Author marks
\newcommand{\orcidlink}[1]{}
%% Affiliations are numbered (authblk); author roles use card-suit marks.
%% Usage: \author[1,\cofirst]{Name}   \author[2,\corr]{Name}
%% Default marks are card suits; class option [plainmarks] switches to
%% conventional footnote symbols (*, double dagger, dagger).
\if@plainmarks
  \newcommand{\cofirst}{$\ast$}           % * co-first / equal contribution
  \newcommand{\colead}{$\ddagger$}        % double dagger, co-lead (optional)
  \newcommand{\corr}{$\dagger$}            % dagger, corresponding author
\else
  \newcommand{\cofirst}{$\diamondsuit$}   % co-first / equal contribution
  \newcommand{\colead}{$\spadesuit$}      % co-lead (optional)
  \newcommand{\corr}{$\clubsuit$}          % corresponding author
\fi
%% Author emails, shown between the author line and the affiliations.
\newcommand{\emails}[1]{\def\@emails{#1}}
\def\@emails{}
%% Front-matter notes (equal contribution / correspondence), shown under affils.
\newcommand{\frontnotes}[1]{\def\@frontnotes{#1}}
\def\@frontnotes{}
%% Email font: Source Code Pro (a clean, modern monospace; sets the tt family).
\RequirePackage{sourcecodepro}
\newcommand{\emailfont}{\ttfamily}

%% Ref to Sup
\RequirePackage{nameref}
\RequirePackage{cleveref}
\crefname{equation}{Eq. S}{equations}
\crefname{figure}{Figure}{figures}
\crefname{section}{Sup. Note}{notes}
\crefname{suppfigure}{Supplementary Figure}{supplementary figures}
\crefname{supptable}{Supplementary Table}{supplementary tables}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package dependencies - End %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Fonts
\if@helvet\RequirePackage{helvet}\fi

%% sizes and margins
\columnsep          7mm
\headsep          6.3mm
\headheight        12pt
\lineskip           1pt
\normallineskip     1pt
\def\baselinestretch{1}

\marginparsep      10pt
\marginparwidth    20pt
\marginparpush     25pt

\partopsep          \z@
\topsep           1.3ex
\parsep             \z@
\itemsep            \z@

%%
\abovedisplayskip       0pt plus2pt minus5pt%
\belowdisplayskip       \abovedisplayskip
\abovedisplayshortskip  0pt plus3pt%
\belowdisplayshortskip  0pt plus3pt minus3pt%

\arraycolsep     5pt
\tabcolsep       6pt
\arrayrulewidth .4pt
\doublerulesep   2pt
\tabbingsep\labelsep

%% footnotes
\skip\footins 10pt plus 4pt minus 2pt
\footnotesep 7pt
\footskip 10mm
\skip\@mpfootins = \skip\footins
\fboxsep = 3pt \fboxrule = .4pt
\long\def\@makefntext#1{\parindent .8em\indent$^{\@thefnmark}$#1}
\def\footnoterule{}


\newdimen\@maxsep
\newdimen\@dblmaxsep
%% Definitions for floats
%%
%% Normal Floats                      %% Double Column Floats
\floatsep 12pt plus 2pt minus 2pt     \dblfloatsep 12pt plus 2pt minus 2pt
\textfloatsep 20pt plus 2pt minus 4pt \dbltextfloatsep 20pt plus 2pt minus 4pt
\@maxsep 20pt                         \@dblmaxsep 20pt
\@fptop 0pt plus 1fil                 \@dblfptop 0pt plus 1fil
\@fpsep 8pt plus 2fil                 \@dblfpsep 8pt plus 2fil
\@fpbot 0pt plus 1fil                 \@dblfpbot 0pt plus 1fil
\def\topfraction{1.0}                 \def\dbltopfraction{1.0}
\def\floatpagefraction{0.8}           \def\dblfloatpagefraction{0.8}
\setcounter{topnumber}{2}             \setcounter{dbltopnumber}{4}
\intextsep 12pt plus 2pt minus 2pt
\setcounter{bottomnumber}{2}
\def\bottomfraction{.1}
\setcounter{totalnumber}{4}
\def\textfraction{.1}
\setlength{\belowcaptionskip}{-10pt} % reduces spacing between figure legend and text

\renewcommand{\topfraction}{0.99}
\if@submit
  \renewcommand{\floatpagefraction}{0.5}
\else
  \renewcommand{\floatpagefraction}{0.8} % changed from 0.5 because single column figs bigger than 0.5 were excluding all text in that column
\fi
\renewcommand{\bottomfraction}{0.99}
\renewcommand{\textfraction}{0.01}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% Layout and front matter - Start %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}\def\@shorttitle{}% default: empty
\newcommand{\leadauthor}[1]{\def\@leadauthor{#1}}\def\@leadauthor{}% default: empty
\newcommand{\footerfont}{\normalfont\sffamily\fontsize{7}{9} \selectfont}
\newcommand{\titlefont}{\fontfamily{lmss}\bfseries\fontsize{18pt}{20pt}\selectfont}
\newcommand{\dropcapfont}{\fontfamily{lmss}\bfseries\fontsize{22pt}{24pt}\selectfont}
\if@submit
  \newcommand{\datesfont}{\normalfont\sffamily\fontsize{7}{9}\selectfont}
  \newcommand{\absfont}{\normalfont\sffamily\bfseries\fontsize{10}{12}\selectfont}
  \newcommand{\keywordsfont}{\normalfont\rmfamily\fontsize{10}{11}\selectfont}
  \newcommand{\copyrightfont}{\normalfont\rmfamily\fontsize{10}{11}\selectfont}
\else
  \newcommand{\headerfont}{\normalfont\sffamily\fontsize{7}{9} \selectfont}
  \newcommand{\datesfont}{\normalfont\sffamily\fontsize{7}{8}\selectfont}
  \newcommand{\absfont}{\normalfont\sffamily\bfseries\fontsize{8}{11}\selectfont}
  \newcommand{\keywordsfont}{\normalfont\rmfamily\fontsize{7}{10}\selectfont}
  \newcommand{\copyrightfont}{\normalfont\rmfamily\fontsize{6}{8}\selectfont}
\fi

%% Set document color scheme
\definecolor{black50}{gray}{0.5} % 50% black for hrules
\definecolor{color0}{RGB}{0,0,0} % Base
\definecolor{color1}{RGB}{40,40,40} % author email, doi

%% Author and affiliation
\if@submit
  %% Author and affiliation
  \setlength{\affilsep}{12pt}
  \renewcommand\Authfont{\color{color1}\normalfont\sffamily\bfseries\fontsize{9}{10}\selectfont}
  \renewcommand\Affilfont{\color{color1}\normalfont\sffamily\fontsize{9}{10}\selectfont}
  \makeatletter
  % uncomment the following line to have affiliations on same line
  % \renewcommand\AB@affilsepx{; \protect\Affilfont}
  \renewcommand\Authands{, and }
\else
  \setlength{\affilsep}{8.5pt} % 16.5pts between base of author line and base of affil line
  \renewcommand\Authfont{\color{color1}\normalfont\sffamily\bfseries\fontsize{9}{11}\selectfont}
  \renewcommand\Affilfont{\color{color1}\normalfont\sffamily\fontsize{7}{8}\selectfont}
  \makeatletter
  % affiliations on separate lines, tight line spacing
  \renewcommand\AB@affilsepx{\protect\\[-3pt]\protect\Affilfont}
  \renewcommand\Authands{, and }
\fi

%% Section/subsection/paragraph set-up
\RequirePackage[explicit]{titlesec}
\renewcommand{\thesubsection}{\Alph{subsection}}
\titleformat{\section}
  {\Large\sffamily\bfseries}
  {}
  {0em}
  {Supplementary Note \thesection: #1}
  []
\titleformat{name=\section,numberless}
  {\Large\sffamily\bfseries}
  {}
  {0em}
  {#1}
  []
\titleformat{\subsection}
  {\sffamily\bfseries}
  {\thesubsection.}
  {0.5em}
  {#1}
  []
\titleformat{\subsubsection}[runin]
  {\sffamily\small\bfseries\itshape}
  {\thesubsubsection.}
  {0.5em}
  {#1. }
  []
\titleformat{\paragraph}[runin]
  {\sffamily\small\bfseries}
  {}
  {0em}
  {#1}

%% from here on there remain differences for the submit style
%% TODO: check these out (from l. 245 in StyleSubmit.cls)
\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{5pt}
\if@submit
  \titlespacing*{\subsection}{0pc}{3ex \@plus4pt \@minus2pt}{4pt}
\else
  \titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{2pt}
\fi
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{2pt}
\titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{12pt}

\if@submit
  \let\oldsection\section
  \renewcommand\section{\clearpage\oldsection}
\fi

%% Figure caption style
\if@submit
  \DeclareCaptionFormat{smallformat}{\normalfont\sffamily\fontsize{9}{12}\selectfont#1#2#3}
\else
  \DeclareCaptionFormat{smallformat}{\normalfont\sffamily\fontsize{7}{9}\selectfont#1#2#3}
\fi
\DeclareCaptionFormat{largeformat}{\normalfont\sffamily\fontsize{9}{12}\selectfont#1#2#3}
\captionsetup*{format=smallformat}

% %% Watermark
% \usepackage[printwatermark]{xwatermark}
% \AtBeginDocument{%
%   \ifwatermark%
%   \newwatermark[allpages,color=gray!20,angle=45,scale=3,xpos=0,ypos=0]{DRAFT}
%   \fi
% }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Layout and front matter - End %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% marks
\def\markboth#1#2{\def\leftmark{#1}\def\rightmark{#2}}
\def\footernote#1{\markboth{#1}{#1}}

%% bibliography
\RequirePackage{chapterbib} % outside of Overleaf, comment this line
\RequirePackage[sectionbib,authoryear,round]{natbib}
\setlength{\bibsep}{3pt plus 0.5pt}
\bibliographystyle{preprint}
\renewcommand{\bibsection}{} % Remove header
\if@submit
  \renewcommand\bibfont{\normalfont\sffamily\fontsize{9}{10}\selectfont} % set font to be sans serif
\else
  \renewcommand\bibfont{\normalfont\sffamily\fontsize{8}{9.5}\selectfont} % set font to be sans serif
\fi

\makeatletter
\renewcommand\@biblabel[1]{ #1.} % Remove brackets from label
\def\tagform@#1{\maketag@@@{\bfseries(\ignorespaces#1\unskip\@@italiccorr)}}
\renewcommand{\eqref}[1]{\textup{{\normalfont Eq.~(\ref{#1}}\normalfont)}}
% \makeatother

%% Title
\def\maketitle{\par
  \begingroup
  \def\thefootnote{} % the \thanks{} mark type is empty
\if@tmptwocolumn
  \twocolumn[\@maketitle]
\else
%  \@maketitle % for some reason tmptwocolumn is not declared so this is a fix
  \@maketitle
\fi
  \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}\let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax
}

%% Author block: author line, then emails, then affiliations.
%% Emails sit just above the affiliations (envelope glyph + monospace font).
\newcommand{\@authorblock}{%
  {\lineskip.5em\large\AB@authlist\par}%
  \ifx\@emails\@empty
    \vskip\affilsep
  \else
    \vskip 3pt{{\Affilfont\Envelope~\emailfont\@emails}\par}\vskip\affilsep
  \fi
  \ifx\AB@affillist\@empty\else{{\Affilfont\AB@affillist}\par}\fi
  \ifx\@frontnotes\@empty\else{\vskip 3pt{\Affilfont\@frontnotes\par}}\fi
}

\if@submit
  \def\@maketitle{\newpage
    \begin{flushleft}
      \vskip0.2em{\sffamily\Huge\bfseries\@title\par}\vskip1.0em%
      \@authorblock
    \end{flushleft}
      \par\vskip 1.4em}

  %% Abstract and keywords
  \def\abstract{\vspace{2em}\par{\normalfont\large\bfseries Abstract}\par\nobreak
    \smallskip\normalsize\normalfont}

  \def\endabstract{\vspace{0.4em}\par\normalsize}

  \def\keywords{
  \ifbfabstract\Affilfont\normalfont\else\footnotesize\fi}
  \def\endkeywords{\vspace{1em}\par\normalsize}

  \newcommand{\at}{\makeatletter @\makeatother}
  \def\corrauthor{
  \noindent\ifbfabstract\Affilfont\normalfont\else\footnotesize\fi  Correspondence:\itshape}
  \def\endcorrauthor{\vspace{1em}\par\normalsize}

  \def\acknowledgements{
  \Affilfont\bfseries ACKNOWLEDGEMENTS\par\mdseries}
  \def\endacknowledgements{\vspace{1em}\par\normalsize}

  \def\contributions{
  \Affilfont\bfseries AUTHOR CONTRIBUTIONS\par\mdseries}
  \def\endcontributions{\vspace{1em}\par\normalsize}

  \def\interests{
  \Affilfont\bfseries COMPETING FINANCIAL INTERESTS\par\mdseries}
  \def\endinterests{\vspace{1em}\par\normalsize}
\else
  \def\@maketitle{\newpage
    \begin{flushleft}
      \vskip0.2em{\sffamily\huge\bfseries\@title\par}\vskip1.0em%
      \@authorblock
    \end{flushleft}
      \par\vskip 1.4em}

  %% Abstract and keywords
  \def\abstract{\par{\normalfont\large\bfseries Abstract}\par\nobreak
    \smallskip\normalsize\normalfont}

  \def\endabstract{\vspace{0.4em}\par\normalsize}

  \def\keywords{%\vspace{-.3em}
  \ifbfabstract\Affilfont\bfseries\else\footnotesize\fi}
  \def\endkeywords{\vspace{0.3em}\par\normalsize}

  \newcommand{\at}{\makeatletter @\makeatother}
  \def\corrauthor{%\vspace{-.3em}
  \noindent\ifbfabstract\Affilfont\bfseries\else\footnotesize\fi  Correspondence:\itshape}
  \def\endcorrauthor{\vspace{0.3em}\par\normalsize}

  \def\acknowledgements{\vspace{1em}
  \Affilfont\bfseries ACKNOWLEDGEMENTS\par\mdseries}
  \def\endacknowledgements{\vspace{0.3em}\par\normalsize}

  \def\contributions{\vspace{.3em}
  \Affilfont\bfseries AUTHOR CONTRIBUTIONS\par\mdseries}
  \def\endcontributions{\vspace{0.3em}\par\normalsize}

  \def\interests{\vspace{.3em}
  \Affilfont\bfseries COMPETING FINANCIAL INTERESTS\par\mdseries}
  \def\endinterests{\vspace{0.3em}\par\normalsize}
\fi

%% =====================================================================
%%  Toolkit: theorems, math macros, emphasis, tables, boxes, symbols.
%%  None of these change the default visual layout; use them as needed.
%% =====================================================================

%% --- Theorem environments (Springer/Nature-style, amsthm) ----------
\newtheoremstyle{thmhead}% numbered theorems: bold head, italic body
  {12pt}{12pt}{\itshape}{0pt}{\bfseries}{.}{.5em}{}
\newtheoremstyle{defnhead}% definitions: bold head, upright body
  {12pt}{12pt}{\normalfont}{0pt}{\bfseries}{.}{.5em}{}
\newtheoremstyle{remarkhead}% remarks: italic head, upright body
  {10pt}{10pt}{\normalfont}{0pt}{\itshape}{.}{.5em}{}
\theoremstyle{thmhead}
\newtheorem{theorem}{Theorem}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\theoremstyle{defnhead}
\newtheorem{definition}{Definition}
\newtheorem{assumption}{Assumption}
\theoremstyle{remarkhead}
\newtheorem{remark}{Remark}
\newtheorem{example}{Example}
% the `proof' environment (with QED square) is provided by amsthm.

%% --- Math operators, delimiters, notation --------------------------
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator{\Var}{Var}
\DeclareMathOperator{\Cov}{Cov}
\DeclareMathOperator{\diag}{diag}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\sign}{sign}
\DeclareMathOperator{\softmax}{softmax}
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
\DeclarePairedDelimiter{\set}{\{}{\}}
\DeclarePairedDelimiter{\inner}{\langle}{\rangle}
\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}
\DeclarePairedDelimiter{\floor}{\lfloor}{\rfloor}
\providecommand{\R}{\mathbb{R}}
\providecommand{\N}{\mathbb{N}}
\providecommand{\Z}{\mathbb{Z}}
\providecommand{\E}{\mathbb{E}}        % expectation
\providecommand{\vect}[1]{\bm{#1}}     % bold vector
\providecommand{\mat}[1]{\bm{#1}}      % bold matrix
\providecommand{\trans}{^{\!\top}}     % transpose superscript

%% --- Colour palette (shared by emphasis macros and callout boxes) --
\definecolor{calloutblue}{HTML}{1F6FB4}
\definecolor{calloutgreen}{HTML}{2E8B57}
\definecolor{calloutamber}{HTML}{C8860D}
\definecolor{calloutred}{HTML}{C0392B}

%% --- Emphasis / annotation macros ----------------------------------
\newcommand{\good}[1]{\textcolor{calloutgreen}{#1}}
\newcommand{\bad}[1]{\textcolor{calloutred}{#1}}
\newcommand{\maybe}{\textcolor{calloutamber}{\textbf{?}}}
\newcommand{\miss}[1]{\textcolor{calloutred}{\emph{[missing: #1]}}}
\newcommand{\hilite}[1]{\textcolor{calloutblue}{\textbf{#1}}}
\newcommand{\best}[1]{\textbf{#1}}
\newcommand{\secondbest}[1]{\underline{#1}}

%% --- Table helpers -------------------------------------------------
\renewcommand{\arraystretch}{1.18}     % roomier rows (journal style)
\setlength{\heavyrulewidth}{0.9pt}     % booktabs top / bottom rules
\setlength{\lightrulewidth}{0.45pt}    % booktabs mid rules
\setlength{\aboverulesep}{0.3ex}\setlength{\belowrulesep}{0.5ex}
\newcommand{\mc}[2]{\makecell[t]{#1\\\scriptsize(#2)}}       % cell + sub-note
\newcommand{\mcb}[2]{\makecell[t]{{\bfseries #1}\\\scriptsize(#2)}}
\newcommand{\na}{\makecell{--}}                               % missing value
\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}            % ragged X column
\newcolumntype{C}{>{\centering\arraybackslash}X}             % centered X column
%% Caption: label bold + sans, sits above the table (journal convention).
\captionsetup[table]{position=above, skip=4pt}

%% --- Check / cross marks -------------------------------------------
\newcommand{\cmark}{\textcolor{calloutgreen}{\ding{51}}}
\newcommand{\xmark}{\textcolor{calloutred}{\ding{55}}}

%% --- Callout / highlight boxes (tcolorbox) -------------------------
% Accent callout: a tinted rounded panel with a colored left bar.
% Recolour via the optional arg, e.g.
%   \begin{highlight}[borderline west={3pt}{0pt}{calloutgreen},colback=calloutgreen!6,colframe=calloutgreen!6]
\newtcolorbox{highlight}[1][]{%
  enhanced, breakable,
  colback=calloutblue!6, colframe=calloutblue!6,
  borderline west={3pt}{0pt}{calloutblue},
  boxrule=0pt, arc=3pt, outer arc=3pt,
  left=11pt, right=9pt, top=7pt, bottom=7pt, #1}
% Titled callout: a hanging title tab over a tinted rounded body + soft shadow.
\newtcolorbox{keypoint}[1][Key point]{%
  enhanced, breakable,
  colback=calloutblue!5, colframe=calloutblue!75!black,
  boxrule=0.5pt, arc=3pt,
  coltitle=white, colbacktitle=calloutblue!75!black,
  fonttitle=\bfseries\sffamily\footnotesize, title={#1},
  attach boxed title to top left={xshift=10pt, yshift=-\tcboxedtitleheight/2},
  boxed title style={arc=2pt, boxrule=0pt},
  drop fuzzy shadow=black!12,
  left=9pt, right=9pt, top=10pt, bottom=7pt}

\if@submit
    \onecolumn \sloppy \flushbottom
\else
    \twocolumn \sloppy \flushbottom
\fi

%% Allows BIOGRAPHY and leaves place for picture
%%
\if@submit
  \newenvironment{biography}[1]{%
  \normalsize\unitlength 1mm\bigskip\bigskip\bigskip\parskip=0pt\par%
  \rule{0pt}{39mm}\vspace{-39mm}\par%   guarantees correct page breaking
  \noindent\setbox0\hbox{\framebox(25,32){}}%   box containing the frame
  \ht0=37mm\count10=\ht0\divide\count10 by\baselineskip%  calculates lines
  \global\hangindent29mm\global\hangafter-\count10%
  \hskip-28.5mm\setbox0\hbox to 28.5mm {\raise-30.5mm\box0\hss}%
  \dp0=0mm\ht0=0mm\box0\noindent\bf#1\rm}{
  \par\rm\normalsize}
\else
  \newenvironment{biography}[1]{%
  \footnotesize\unitlength 1mm\bigskip\bigskip\bigskip\parskip=0pt\par%
  \rule{0pt}{39mm}\vspace{-39mm}\par%   guarantees correct page breaking
  \noindent\setbox0\hbox{\framebox(25,32){}}%   box containing the frame
  \ht0=37mm\count10=\ht0\divide\count10 by\baselineskip%  calculates lines
  \global\hangindent29mm\global\hangafter-\count10%
  \hskip-28.5mm\setbox0\hbox to 28.5mm {\raise-30.5mm\box0\hss}%
  \dp0=0mm\ht0=0mm\box0\noindent\bf#1\rm}{
  \par\rm\normalsize}
\fi

%% Default rules for including pictures
\RequirePackage{graphicx}
\RequirePackage{color}
\DeclareGraphicsRule{*}{eps}{*}{}

%% Page headers and footers
%%
\RequirePackage{fancyhdr} % Custom headers/footers
\RequirePackage{lastpage} % Number of pages in the document
\pagestyle{fancy}		  % Enables the custom headers/footers

%% --- Footer: uniform on every page --------------------------------
%% Left foot : lead author (optional; drop with class option [nofootauthor]).
%% Right foot: short title | page number (no date, no total-page count).
\newcommand{\@footleft}{%
  \if@footauthor \footerfont \@leadauthor
    \ifnum\value{authors}>2\hspace{2pt}\textit{et al.}\fi \fi}
\newcommand{\@footright}{\footerfont \@shorttitle\hspace{7pt}|\hspace{7pt}\thepage}
\newcommand{\@footlogo}{%
  \includegraphics[width=1cm, trim=0 1.5cm 0 0]{assets/footer_logo}}

\lfoot{\@footleft}
\rfoot{\@footright}

\rhead[]{\footnotesize\rightmark}
\lhead[\footnotesize\leftmark]{}
\cfoot{}
\renewcommand{\headrulewidth}{0pt}
\setlength{\headheight}{28pt}   % room for the header logos

%% Title-page style: dual logos in the header; footer identical to body
%% pages, with an optional logo prefix at the right ([firstfootlogo]).
\fancypagestyle{plain}{%
\fancyhf{}%
\fancyhead[L]{\includegraphics[height=0.8cm]{assets/logo_left}}%
\fancyhead[R]{\includegraphics[height=0.7cm]{assets/logo_right}}%
\renewcommand{\headrulewidth}{0pt}%
\lfoot{\@footleft}%
\rfoot{\if@firstfootlogo\@footlogo\hspace{7pt}|\hspace{7pt}\fi\@footright}%
}

\def\sectionmark#1{\relax}

\parindent=0pt
\endinput
