%=====================================================================
% Identificação
%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ppgihd}[2020/01/25 v1.0.0 Formatacao de documentos dissertacao e tese do PPGIHD]

%=====================================================================
% Declaração de opções
%=====================================================================
\DeclareOption{english}{\@englishtrue\OptionNotUsed}\newif\if@english
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%=====================================================================
% Herança da classe `report' e inclusão de pacotes e arquivos necessários
%=====================================================================
\LoadClass[12pt,a4paper]{report}
\RequirePackage[brazilian]{babel}
\input{babel/brazilian.babel}
%\input{babel/english.babel}
%\RequirePackag{tocloft}
%\RequirePackag{octofilo}
%\RequirePackag{clofoctol}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{indentfirst}      %identa primeiro parágrafo
\RequirePackage{graphicx}         %imagens
\RequirePackage{amsmath}          %formulas matemáticas
\RequirePackage{hyperref}         %referências
\RequirePackage{fancyhdr}         %manipulação de header e footer
\RequirePackage{setspace}
\RequirePackage{ppgihd-defs}           %especifico para ufrj/im/dcc

\RequirePackage{color}
\RequirePackage{listings}

\RequirePackage[alf]{abntex2cite}	% Citações padrão ABNT
\RequirePackage{microtype} 			% para melhorias de justificação

\RequirePackage{booktabs}           % comandos extras para as tabelas

\RequirePackage[table]{xcolor}      % definir cor para as linhas da tabela
\RequirePackage{geometry}
\setlength{\paperheight}{297mm}
\setlength{\paperwidth}{210mm}


\RequirePackage{csquotes}           % citações de frases


	\geometry{
		paperheight =   297mm,
		paperwidth  =   210mm,
		top         =   30mm,
		bottom      =   20mm,
		outer       =   20mm, 
		inner       =   30mm,
		footskip    =   3mm,
		headsep     =   3mm,
		headheight  =   3mm,
	}

\newcommand*{\eg}{\textit{e.g.}\@\xspace}
\newcommand*{\ie}{\textit{i.e.}\@\xspace}

\def\@chapter[#1]#2{
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{\@chapapp\space\thechapter.}%
		\addcontentsline{toc}{chapter}{\bfseries\thechapter~{#1}}
		%{\protect\numberline{\thechapter}#1}%
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{10\p@}}%
	\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\if@twocolumn
		\@topnewpage[\@makechapterhead{#2}]%
	\else
		\@makechapterhead{#2}%
		\@afterheading
	\fi}


\renewcommand{\thechapter}{
	\Roman{chapter}
}
%\renewcommand{\thechapter}{\Roman{chapter}}
%\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\@arabic\c@chapter.\@arabic\c@section}


%==============================================================================
% Códigos
%==============================================================================
\newcommand{\codejava}[3]{
  \mbox{
    \lstset{framexleftmargin=5mm, frame=shadowbox, rulesepcolor=\color{gray}}
    \lstinputlisting[language=Java,
      breaklines=true,
      basicstyle=\footnotesize\ttfamily,
      keywordstyle=\bfseries\color{purple},
      commentstyle=\itshape\color{dkgreen},
      stringstyle=\color{orange},
      showstringspaces=false,
      rulecolor=\color{black},
      caption=#1,label=#2]{#3}
  }
}

\newcommand{\codec}[3]{
  \mbox{
    \lstset{framexleftmargin=5mm, frame=shadowbox, rulesepcolor=\color{gray}}
    \lstinputlisting[language=C,
      breaklines=true,
      basicstyle=\footnotesize\ttfamily,
      keywordstyle=\bfseries\color{dkgreen},
      commentstyle=\itshape\color{purple},
      identifierstyle=\color{blue},
      stringstyle=\color{orange},
      showstringspaces=false,
      caption=#1,label=#2]{#3}
  }
}

%=====================================================================
% Referências
%=====================================================================
\newcommand{\reffigure}[1]{\figurename~\ref{#1}}
\newcommand{\reftable}[1]{\tablename~\ref{#1}}
\newcommand{\reflisting}[1]{\lstlistingname~\ref{#1}}
\newcommand{\refchapter}[1]{\chaptername~\ref{#1}}
\newcommand{\refsection}[1]{\sectionname~\ref{#1}}
\newcommand{\refequation}[1]{\equationname~\ref{#1}}
\newcommand{\refappendix}[1]{\appendixname~\ref{#1}}

%=====================================================================
% Numeração das páginas
%=====================================================================
\newcommand{\startdocument}{
  \setcounter{page}{1}
  \pagenumbering{roman}
  \pagestyle{plain}
}

\newcommand{\startcontent}{
  \setcounter{page}{1}
  \pagenumbering{arabic}
  \pagestyle{fancyplain}
  \lhead[\fancyplain{}{\bfseries\thepage}]{\fancyplain{}{\bfseries\rightmark}}
  \rhead[\fancyplain{}{\bfseries\leftmark}]{\fancyplain{}{\bfseries\thepage}}
  \cfoot{}
}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

%=====================================================================
% Definição de autor(es), orientador, co-orientador e banca
%=====================================================================
\renewcommand{\author}[2]{
  \gdef\@authorname{#1}
  \gdef\@authorlastname{#2}
  \gdef\@author{#1 #2}
}

\newcounter{ii@bancacount}
\DeclareRobustCommand{\banca}[3][]{
  \addtocounter{ii@bancacount}{1}
  \expandafter\gdef\csname @banca\alph{ii@bancacount}\endcsname{#1~#2}
  \expandafter\gdef\csname @banca\alph{ii@bancacount}name\endcsname{#2}
  \expandafter\gdef\csname @banca\alph{ii@bancacount}origin\endcsname{#3}
}

%=====================================================================
% Definição do Departamento relacionado ao documento
% deve ser definido como 'dcc'
%=====================================================================
\newcommand{\dept}[1]{\gdef\@dept{#1}}

%=====================================================================
% Redefinição da data (para ter mês e ano separados)
%=====================================================================
\renewcommand{\date}[2]{
        \gdef\@publmonth{#1}
        \gdef\@publyear{#2}
}
\date{\monthname}{\number\year}

%=====================================================================
% Formatação das tabela de conteúdo (Sumário)

%=====================================================================

\setcounter{tocdepth}{4}

%=====================================================================
% Formatação das seções
%=====================================================================
\setcounter{secnumdepth}{4}
\renewcommand{\section}{%
  \@startsection{section}{1}{0pt}{18pt}{9pt}{\reset@font\large\bfseries}
}
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{0pt}{12pt}{6pt}{\reset@font\bfseries}
}
\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{0pt}{12pt}{6pt}{\reset@font\itshape}
}
\renewcommand{\paragraph}{%
  \@startsection{paragraph}{4}{0pt}{12pt}{6pt}{\reset@font}
}
\renewcommand{\subparagraph}{%
  \@startsection{subparagraph}{5}{0pt}{1ex}{-1em}{\reset@font\bfseries}
}

%=====================================================================
% Definição padrão da folha de rosto.
%=====================================================================
\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{95mm}
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{64mm}
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{112mm}
\newcommand{\location}[3]{
  \gdef\@city{#1}
  \gdef\@state{#2}
  \gdef\@country{#3}
}
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \thefirsttitlepage
  \end{titlepage}%
  \clearpage
  \thesecondtitlepage
  %\@makeapprovalpage
}

\newcommand{\thefirsttitlepage}{%
  \thispagestyle{empty}
  \noindent\@topbox\\
  \vfill
  \centerline{\textbf{\year}}
}

\newcommand{\orientador}[1]{ \gdef\@advisorm{#1} }
\newcommand{\orientadora}[1]{ \gdef\@advisorf{#1} }

\newcommand{\coorientador}[1]{ \gdef\@coadvisorm{#1} }
\newcommand{\coorientadora}[1]{ \gdef\@coadvisorf{#1} }

\newcommand{\thesecondtitlepage}{%
  \thispagestyle{empty}
  \noindent\@topboxex\\
  \vfill

  \ifdefined\@advisorm
    \centerline{Sob a Orienta{\c{c}}{\~a}o do professor}
    \centerline{\@advisorm}
    \vfill
  \fi

  \ifdefined\@advisorf
    \centerline{Sob a Orienta{\c{c}}{\~a}o da professora}
    \centerline{\@advisorf}
    \vfill
  \fi

  \ifdefined\@coadvisorm
    \centerline{e Co-orienta{\c{c}}{\~a}o do professor}
    \centerline{\@coadvisorm}
    \vfill
  \fi

  \ifdefined\@coadvisorf
    \centerline{e Co-orienta{\c{c}}{\~a}o da professora}
    \centerline{\@coadvisorf}
    \vfill
  \fi

  
  \hspace*{\fill}\parbox[b]{.5\textwidth}{\mestrado}
  \vfill
  \centerline{\@city, \@state}
  \centerline{\ii@date}
}



\def\@topbox{%
  \parbox[t]{\textwidth}{%
    \centering%
    \vbox to \titlepagewinvoffset{%
      \textbf{\titlepagetopinfo}\vfill\textbf{\@winbox}
    }
  }
}


\def\@topboxex{%
  \parbox[t]{\textwidth}{%
    \centering%
     \vbox to \titlepagewinvoffset{%
     \includegraphics[scale=0.1]{logo-ufrrj.png}\\
      \textbf{\titlepagetopinfoex}\vfill\textbf{\@winboxex}
    }
  }
}


\def\@winbox{
  \parbox[b]{\titlepagewinwidth}{
    \centering\vbox to \titlepagewinheight{
      %\vspace*{\fill}
      
      \vspace{\stretch{5}}{\MakeUppercase{\dissertacao}\par}
      \vspace{\stretch{2}}{\@title\par}
      \vspace{\stretch{3}}
      \@author\\ %#here
      
      \vfill
    }
  }
}

\def\@winboxex{
  \parbox[b]{\titlepagewinwidth}{
    \centering\vbox to \titlepagewinheight{
      %\vspace*{\fill}
      \vspace{\stretch{3}}{\MakeUppercase{\@title}\par}
      \vspace{\stretch{3}}
      \MakeUppercase{\@author}\\ %#here
      
      \vfill
    }
  }
}


\newcommand{\curso}[1]{\gdef\@curso{#1}}
\newcommand{\titlepagetopinfo}{%
  \MakeUppercase{\ufrrj}\\
  \MakeUppercase{\im}\\
  \MakeUppercase{\ppg}\\
  %\@ifundefined{@dept}{}{\MakeUppercase{\csname \@dept\endcsname}\\}%
  %\@ifundefined{@curso}{}{\MakeUppercase{\csname \@curso\endcsname}\\}%
}

\newcommand{\titlepagetopinfoex}{%
  \MakeUppercase{\ufrrjex}\\
  \MakeUppercase{\im}\\
  \MakeUppercase{\ppg}\\
  %\@ifundefined{@dept}{}{\MakeUppercase{\csname \@dept\endcsname}\\}%
  %\@ifundefined{@curso}{}{\MakeUppercase{\csname \@curso\endcsname}\\}%
}

\renewcommand\@dotsep{10000}

%=====================================================================
% Agradecimentos (thanks)
%=====================================================================
\newcommand{\makethanks}[1] {
	\newpage
	\begin{center}
		\textbf{AGRADECIMENTOS} \linebreak
	\end{center}
	\renewcommand{\baselinestretch}{1.5}
	\normalsize
	{#1}
	\linebreak
	\pagebreak
}
%\newcommand{thanks}[1]{%
%	\begin{center}
%		\textbf{AGRADECIMENTOS} \linebreak
%	\end{center}
%	\renewcommand{\baselinestretch}{1.5}
%	\normalsize
%	{#1}
%	\linebreak
%}
%{
%	\pagebreak
%}
%=====================================================================
% Resumo (abstract) e Abstract (englishabstract)
%=====================================================================
\renewenvironment{abstract}[4]{
  \if@english
  \else
    \pagebreak
    \addcontentsline{toc}{chapter}{RESUMO}
    \begin{center}
      \textbf{RESUMO} \linebreak
    \end{center}
    \renewcommand{\baselinestretch}{1.5}
    \normalsize
    {#1}
    \linebreak
    \vfill
    \textbf{Palavras-chave:} {#2}. {#3}. {#4}
    %\Palavraschave
  \fi
}
{
  \pagebreak
}

\newenvironment{englishabstract}[4]{
  \addcontentsline{toc}{chapter}{ABSTRACT}
  \begin{center}
    \textbf{ABSTRACT} \linebreak
  \end{center}

  \renewcommand{\baselinestretch}{1.5}
  \normalsize
  {#1}
  \linebreak
  \vfill
  \textbf{Key words:} {#2}. {#3}. {#4}
  %\Keywords
}
{
  \pagebreak
}

%=====================================================================
% Redefinição do conteúdo das listas de figuras e tabelas
%=====================================================================
\newif\if@captionlisting\@captionlistingtrue
\long\def\@caption#1[#2]#3{%
  \par
  \if@captionlisting%
    \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{\csname fnum@#1\endcsname:}{\ignorespaces #2}}%
  \fi%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup%
}
\renewcommand*{\l@figure}{\@dottedtocline{1}{0em}{5.5em}}
\let\l@table\l@figure

%=====================================================================
% Definição do conteúdo de agradecimentos
%=====================================================================
\newcommand{\makethankspage}{
  \chapter*{Agradecimentos}
  \addcontentsline{toc}{chapter}{Agradecimentos}
  
  %\@ifundefined{@authorb}{}{\underline{\@authora}}
  
  %\@authorathanks %#here
  \newpage
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de figuras
%=====================================================================

%\renewcommand{\listoffigures}{%
%	\section*{\huge\contentsname
%		\@mkboth{%
%			\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%	\@startlof{lof}%
%}


\newcommand{\makefigurespage}{
%  \addcontentsline{toc}{chapter}{\listfigurename}
%  \listoffigures
    \if@twocolumn
		\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\centering\normalsize\MakeUppercase\listfigurename}%
		\@mkboth{\MakeUppercase\listfigurename}%
		{\MakeUppercase\listfigurename}%
	\@starttoc{lof}%
	\if@restonecol\twocolumn\fi
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de tabelas
%=====================================================================
\newcommand{\maketablespage}{
  \addcontentsline{toc}{chapter}{\uppercase{\listtablename}} 
  
  \if@twocolumn
	\@restonecoltrue\onecolumn
  \else
   	\@restonecolfalse
  \fi
  \chapter*{\centering\normalsize\MakeUppercase\listtablename}%
    \@mkboth{%
	    \MakeUppercase\listtablename}%
	    {\MakeUppercase\listtablename}%
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi

  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de algoritmos
%=====================================================================
\newcommand{\makelistingspage}{
	%  \addcontentsline{toc}{chapter}{LISTA DE ABREVIAÇÕES E SÍMBOLOS}
	
  \addcontentsline{toc}{chapter}{\uppercase{\lstlistlistingname}} 
%  \lstlistoflistings{}
  \if@twocolumn
	\@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\centering\normalsize\MakeUppercase\lstlistlistingname}%
  \@mkboth{%
	  \MakeUppercase\lstlistlistingname}%
      {\MakeUppercase\lstlistlistingname}%
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi

%------------------------------------------------------
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de abreviaturas e símbolos
%=====================================================================
\newcommand{\makeabrevpage}[1]{

  \begin{listofabbrv}{XXXXXX}
    #1
  \end{listofabbrv}
  \pagebreak
}{}

\newcommand{\makesymbolspage}[1]{
  \begin{listofsymbols}{XXXXXX}
    #1
  \end{listofsymbols}
  \pagebreak
}{}

%=====================================================================
% Definição das listas de abreviaturas e siglas e de símbolos
%=====================================================================
\newenvironment{listofabbrv}[1]{
	\begin{center}
		\textbf{LISTA DE ABREVIAÇÕES E SÍMBOLOS} \linebreak
	\end{center}
  %\chapter*
  \addcontentsline{toc}{chapter}{LISTA DE ABREVIAÇÕES E SÍMBOLOS}
  \begin{list}{\textbf{??}}{
	\setstretch{-0.250}
    \settowidth{\labelwidth}{#1}
    \setlength{\labelsep}{5em}
    \setlength{\itemindent}{0mm}
    \setlength{\leftmargin}{\labelwidth}
      \addtolength{\leftmargin}{\labelsep}
    \setlength{\rightmargin}{0mm}
    \setlength{\itemsep}{.1\baselineskip}
    \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
  }
}
{
  \end{list}
}

%=====================================================================
% Definição do conteúdo da tabela de conteúdo
%=====================================================================

\addtocontents{toc}{%
	\begingroup
	% Default definitions of \l@section and \l@subsection in book.cls
	% https://www.tug.org/svn/texlive/trunk/Master/texmf-dist/tex/latex/base/book.cls?view=co
	% \newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
	% \newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
	\protect\renewcommand{\protect\l@chapter}{\protect\@dottedtocline{1}{0pt}{1em}}%
	\protect\renewcommand{\protect\l@section}{\protect\@dottedtocline{2}{0pt}{2em}}%
	\protect\renewcommand{\protect\l@subsection}{\protect\@dottedtocline{3}{0pt}{3em}}%
	\protect\renewcommand{\protect\l@subsubsection}{\protect\@dottedtocline{4}{0pt}{4em}}%

%\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
%\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}

}

%Sumário 
\newcommand{\maketocpage}{
	\singlespacing
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\centering\normalsize\MakeUppercase\contentsname
		\@mkboth{%
			\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
	\@starttoc{toc}%
	\if@restonecol\twocolumn\fi
  \pagebreak
  \onehalfspacing
}{}

%=====================================================================
% Definição do conteúdo da bibliografia
%=====================================================================
\newcommand{\makebibspage}[1]{
  \addcontentsline{toc}{chapter}{\bibname}
  \bibliography{#1}
}{}
