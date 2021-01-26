%=====================================================================
% Identificação
%=====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{projeto-ppgihd}[2020/01/25 v1.0.0 Formatacao de documentos para o programa de Pós-Graduação em Humanidades Digitais da UFRRJ]

%=====================================================================
% Herança da classe `report' e inclusão de pacotes e arquivos necessários
%=====================================================================
\LoadClass[12pt,a4paper]{report}
\RequirePackage[portuguese]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{indentfirst}      %identa primeiro parágrafo
\RequirePackage{graphicx}         %imagens
\RequirePackage{amsmath}          %formulas matemáticas
\RequirePackage{hyperref}         %referências
\RequirePackage{fancyhdr}         %manipulação de header e footer
%\RequirePackage{iidefs}           %especifico para ufrj/im/dcc
\RequirePackage{color}
\RequirePackage{listings}
\RequirePackage[alf]{abntex2cite}	% Citações padrão ABNT
\RequirePackage{microtype} 			% para melhorias de justificação
\RequirePackage{booktabs}           % comandos extras para as tabelas
\RequirePackage[table]{xcolor}      % definir cor para as linhas da tabela
\RequirePackage{csquotes}           % citações de frases



\renewcommand{\maketitle}{%
  \begin{titlepage}
    \thefirsttitlepage
  \end{titlepage}%
  \clearpage
  \@makeapprovalpage
}

\newcommand{\thefirsttitlepage}{%
  \thispagestyle{empty}
  \noindent\@topbox\\
  \vfill
  \@ifundefined{@advisor}{}{
    \hspace*{\fill}\parbox[b]{.5\textwidth}{%
                        {\titlepageadvisorinfo}
                    }
    \vfill
  }
  \centerline{\@city, \ii@date}
}

\def\@topbox{%
  \parbox[t]{\textwidth}{%
    \centering%
    \vbox to \titlepagewinvoffset{%
      \titlepagetopinfo\vfill\@winbox
    }
  }
}

\def\@winbox{
  \parbox[b]{\titlepagewinwidth}{
    \centering\vbox to \titlepagewinheight{
      \vspace*{\fill}
      \MakeUppercase{\@authora}\\
      \@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}
      \@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}
      \vspace{\stretch{4}}{\large\textbf{\@title}\par}
      \vfill
    }
  }
}

\newcommand{\curso}[1]{\gdef\@curso{#1}}
\newcommand{\titlepagetopinfo}{%
  \MakeUppercase{\ufrrj}\\
  \MakeUppercase{\im}\\
  \MakeUppercase{\cbcc}\\
}

\newcommand{\titlepageadvisorinfo}{%
  \@ifundefined{@advisor}{}{\vfill\@advisor\\\advisorname}
  \@ifundefined{@coadvisor}{}{\\[6ex]\@coadvisor\\\coadvisorname}
}
