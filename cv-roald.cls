\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv-roald}[2017/09/10 My custom CV class v3.0.0]
\LoadClass[a4paper]{article}

% ---------------------------------------------------------------------------- %
%                                 PARAMETERS                                   %
% ---------------------------------------------------------------------------- 




%
% Size of the margin
\newlength{\margin}
\setlength{\margin}{25mm}

% Size of the left column
\newlength{\leftcol}
\setlength{\leftcol}{40 mm}

% Height of the header
\newlength{\hdrheight}
\setlength{\hdrheight}{28mm}

% Size of the left column for publication
\newlength{\publeft}
\setlength{\publeft}{10 mm}


% Vertical space between rows/paragraphs
\newlength{\vspacepar}
\setlength{\vspacepar}{0.6\baselineskip}

% Horizontal space before and after vertical bar (|) between address and 
% the contact details
\newlength{\hspaddress}
\setlength{\hspaddress}{1em}

% Horizontal space after font awesome icons
\newcommand{\FAspace}{\hspace{0.0 em}}

% Left indentation (before the bullet) of an itemized list
\setlength{\leftmargini}{2em}

% # REQUIRED PACKAGES
% Adjust the margins of a page
\RequirePackage[margin = \margin, top = \hdrheight]{geometry} 
\RequirePackage{paralist}
\RequirePackage{fancyhdr}

% ---------------------------------------------------------------------------- %
%                              CALCULATED LENGTHS                              %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To calculate lengths, for example the skip after the header
\RequirePackage{calc} 

% Width of the right column
\newlength{\rightcol}
\setlength{\rightcol}{\textwidth-\leftcol}

%Width of the right column publication
\newlength{\pubright}
\setlength{\pubright}{\textwidth-\publeft}

% ---------------------------------------------------------------------------- %
%                              CLASS OPTION                                    %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Use options in key value format for package options
% For more info on why this is needed see: 
% https://tex.stackexchange.com/questions/383144/pass-rgb-colours-to-custom-class
\RequirePackage{kvoptions-patch}
% Flexible macros for defining and setting keys
\RequirePackage{xkeyval} %
% Draw things (needed for the header). Load before color package!
\RequirePackage{tikz} 
% Enable the use of colours
\RequirePackage{color} 

% Add option to change the color of the header and titles
% \define@key[<prefix>]{<family>}{<key>}[<default>]{<function>}
\define@key{cv-roald.cls}{changecolor}[169, 53, 40]{%
    \definecolor{main}{RGB}{#1}%
}

% Process changecolor to define main color, else colorharmony and titlecolor
% will not work correctly.
\ExecuteOptionsX{changecolor}
\ProcessOptionsX%

\define@key{cv-roald.cls}{colorharmony}[wheel,2,3]{%
    \colorlet{second}{main>#1}%
}

% Process colorharmony to define second color, or else titlecolor will not work.
\ExecuteOptionsX{colorharmony}
\ProcessOptionsX%

\define@key{cv-roald.cls}{titlecolor}[main]{%
    \colorlet{title}{#1}%
}

\ExecuteOptionsX{titlecolor}
\ProcessOptionsX%

% ---------------------------------------------------------------------------- %
%                                     FONTS                                    %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Needed to run XeLaTeX
\RequirePackage{fontspec}
% Important to add, else fontawesome will not work with XeLaTeX 
\defaultfontfeatures{ 
  Path = Fonts/
}
% Load cool icons, such as the linked in logo
\RequirePackage{fontawesome} 

\setmainfont{SourceSansPro}[ 
  Path = Fonts/,
  Extension = .otf ,
  UprightFont = *-Light,
  ItalicFont = *-LightIt,
  BoldFont = *-Semibold,
]    

\newfontfamily\titlefont{AdventPro}[ 
  Path = Fonts/,
  Extension = .ttf,
  UprightFont = *-ExtraLight,
  BoldFont = *-SemiBold,
]   

\newfontfamily\bodyfont[
  Path=Fonts/,
  UprightFont=*-Regular,
  ItalicFont=*-It,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldIt
]{SourceSansPro}

\newfontfamily\bodyfontlight[
  Path=Fonts/,
  UprightFont=*-Light,
  ItalicFont=*-LightIt,
  BoldFont=*-Semibold,
  BoldItalicFont=*-SemiboldIt
]{SourceSansPro}

%-------------------------------------------------------------------------------
%                Configuration for colors
%-------------------------------------------------------------------------------
% Gray-scale colors
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{5D5D5D}
\definecolor{lightgray}{HTML}{999999}
% Basic colors
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
% Text colors
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
\colorlet{lighttext}{lightgray}
% Awesome colors
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}
\colorlet{awesome}{awesome-red}

%%--------------------------------------------
%               font size
%%--------------------------------------------

\def\@xlarge{25pt}
\def\@large{16pt}
\def\@medium{11pt}
\def\@small{10pt}
\def\@xsmall{8pt}



% ---------------------------------------------------------------------------- %
%                                   HEADER                                     %
% ---------------------------------------------------------------------------- %
\newcommand\tab[1][2.5mm]{\hspace*{#1}}
% Separator with a horizontal space before and after. Is used in the header as 
% a separator between address and contact details
\newcommand{\sep}{\hspace{\hspaddress} | \hspace{\hspaddress}}

% This places a header on top of the page.
% #1 First name
% #2 Last name
% #3 = Address
% #4 = Phone, mail and LinkedIn
\newcommand{\header}[4]{%
  \begin{tikzpicture}[remember picture, overlay]
    % Colored bar on top of the page
    \node[
        below right, 
        fill=main, 
        minimum height=\hdrheight, 
        minimum width=\paperwidth, 
        outer sep=0,
      ] (name) at (current page.north west) {};
    % Node for the name
    \node[
        anchor=base, 
        text=white,
        inner sep=0.25 cm,
      ] (nametext) at (name.base) {%
        \fontsize{30pt}{22pt}\color{black}%
        {\titlefont #1~}{\titlefont \textbf{#2}\par}
        };
    % Address
    \node[
        anchor=north, 
        text=black,
      ] (address) at (nametext.south) {#3\par};
    % Phone/mail/nationality
    \node[
        anchor=north, 
        text=black,
      ] at (address.south)  {#4\par};
  \end{tikzpicture}
} 

% Places a picture on the top right of the page
\newcommand{\photo}[1]{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[
        anchor=north east, 
        inner sep=0 pt,
        outer sep=0 pt,
      ] at (current page.north east)
        {\includegraphics[height=\hdrheight]{#1}\par};    
  \end{tikzpicture}%
  % Fix when picture is added, else the text moves down. 
  \vspace*{-1.5\baselineskip}
}%


% ---------------------------------------------------------------------------- %
%                                  TITLE FORMAT                                %
% ---------------------------------------------------------------------------- %


% # REQUIRED PACKAGES
% To alter the style and spacing of titles 
\RequirePackage{titlesec} 

% Change format of the section title
\titleformat{\section}%
  {\titlefont\color{title}\Large\bfseries}{\thesection}{0em}{}
% \titlespacing{command}{left spacing}{before spacing}{after spacing}[right]
\titlespacing*{\section}%
  {0pt}{1ex plus 0.2ex minus 0.2ex}{-1ex plus 0.1ex minus 0.1ex}

% Defines a new command which can be used as a formatter for your Job title and 
% location.
% example: \worktitle{Study name/Job title}{Location}.
% #1 = Job or education title 
% #2 = Company and location
\newcommand{\worktitle}[2]{
  {\bfseries\MakeUppercase{#1}}  
  {\itshape #2}
}

%For subsection
\newcommand*{\subsectionstyle}[1]{{\fontsize{\@medium}{1em}\bodyfont\scshape\textcolor{text}{\textbf #1}}}

% Define a subsection for CV
% Usage: \cvsubsection{<subsection-title>}
\newcommand{\cvsubsection}[1]{
  %\phantomsection{}
  \subsectionstyle{#1}
}

% For elements of entry
\newcommand*{\entrytitlestyle}[1]{{\fontsize{\@medium}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{\@xsmall}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{\@xsmall}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{\@xsmall}{1em}\bodyfontlight\slshape\color{awesome} #1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{\@small}{1em}\bodyfontlight\upshape\color{text} #1}}



% Define a footer for CV
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\footerstyle}[1]{{\fontsize{8pt}{1em}\footerfont\scshape\color{lighttext} #1}}

\newcommand*{\makecvfooter}[3]{
  \fancyfoot{}
  \fancyfoot[L]{
    \footerstyle{#1}
  }
  \fancyfoot[C]{
    \footerstyle{#2}
  }
  \fancyfoot[R]{
    \footerstyle{#3}
  } 
}


% ---------------------------------------------------------------------------- %
%                               ENVIRONMENTS                                   %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Increase spacing after text, between rows
\usepackage{cellspace}
\setlength{\cellspacebottomlimit}{\vspacepar}

% New environment with two columns, a narrow one on the left for the dates and
% a right one for what was done during that period.
\newenvironment{tabularcv}{%
  \par\noindent
  \begin{tabular}{
      @{}>{\raggedright\arraybackslash}S{p{\leftcol}}
      @{}>{\raggedright\arraybackslash}S{p{\rightcol}}
    }
  }
  {\end{tabular}}
  
\newenvironment{cvpublications}{%
  \par\noindent
  \begin{tabular}{
      @{}>{\raggedright\arraybackslash}S{p{\publeft}}
      @{}>{\raggedright\arraybackslash}S{p{\pubright}}
    }
  }
  {\end{tabular}}
  
%-------------------------------------------------------------------------------
%                Commands for utilities
%-------------------------------------------------------------------------------
% Use to align an element of tabular table

\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% For elements of honor

\newcommand*{\honortitlestyle}[1]{{\fontsize{\@small}{1em}\bodyfont\color{graytext} #1}}
\newcommand*{\honorpositionstyle}[1]{{\fontsize{\@small}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\honordatestyle}[1]{{\fontsize{\@small}{1em}\bodyfont\color{graytext} #1}}
\newcommand*{\honorlocationstyle}[1]{{\fontsize{\@xsmall}{1em}\bodyfontlight\slshape\color{graytext} #1}}



% Define an environment for cvhonor
\newenvironment{cvhonors}{
  \begin{center}
    \setlength\tabcolsep{0pt}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} C{1.5cm} L{13.0cm} R{2.5cm}}
}{
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(honor, award or something else)
% Usage: \cvhonor{<position>}{<title>}{<location>}{<date>}


\newcommand*{\cvhonor}[4]{
  \honordatestyle{#4} & \honorpositionstyle{#1}, \honortitlestyle{#2} & \honorlocationstyle{#3}
  \\
}

% For elements of project
\newcommand*{\projecttitlestyle}[1]{{\fontsize{\@medium}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\projectdescriptionstyle}[1]{{\fontsize{\@small}{1em}\bodyfontlight\color{text} #1}}

% For elements of ref
\newcommand*{\reftitlestyle}[1]{{\fontsize{\@small}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\refdescription}[1]{{\fontsize{\@xsmall}{1em}\bodyfontlight\color{text} #1}}

\newcommand{\projectitem}[2]{
    \item\projecttitlestyle{#1} \\
    \projectdescriptionstyle{#2}
}

\newcommand{\cvdoublecolumn}[2]{%
    \begin{center}
    \begin{minipage}[t]{5in} { #1}\end{minipage}%
        \begin{minipage}[t]{3in} { #2}\end{minipage}%
    \end{center}
}

\newcommand{\cvreference}[7]{%
    \textbf{\reftitlestyle #1}\newline% Name
    \ifthenelse{\equal{#2}{}}{}{\refdescription {#2}\newline}%
    \ifthenelse{\equal{#3}{}}{}{\refdescription{#3}\newline}%
    \ifthenelse{\equal{#4}{}}{}{\refdescription {#4}\newline}%
    \ifthenelse{\equal{#5}{}}{}{\refdescription {#5}\newline}%
    \ifthenelse{\equal{#6}{}}{}{{\refdescription{\faEnvelope\ {#6}}}\newline}%
    \ifthenelse{\equal{#7}{}}{}{\refdescription {#7}}}


% ---------------------------------------------------------------------------- %
%                              BODY TEXT OPTIONS                               %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To change \parindent and it adjusts the skips between list items.
\RequirePackage{parskip}

% Remove indent at the start of a new paragraph
\setlength{\parindent}{0pt}  

\RequirePackage{hyperref}
\hypersetup{colorlinks=true, urlcolor=second}
% Places a link to a website with a fontawesome logo
\newcommand{\link}[1]{\href{#1}{\faExternalLink}}  

% ---------------------------------------------------------------------------- %
%                        		      PATCH           	                       %
% ---------------------------------------------------------------------------- %
% # REQUIRED PACKAGES
\RequirePackage{xpatch}

% Patch to prevent package color and cellspace to clash
% More info: https://tex.stackexchange.com/questions/384664/xcolor-package-disables-cellspace-package
\makeatletter
\xpatchcmd{\@endpbox}{\color@endgroup}{\expandafter\color@endgroup}{}{\ddt}
\makeatother