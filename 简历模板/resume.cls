% 作者: 二两拉菲多加醋
% 链接: https://github.com/ZhouMuzhi/Sharement/edit/main/%E7%AE%80%E5%8E%86%E6%A8%A1%E6%9D%BF


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2023/10/12 Custom Resume Class]

% article类与字体大小设置
\LoadClass{article}

% 支持 UTF-8 编码和中文字体
\RequirePackage[UTF8]{ctex}

% % 设置全局字体为楷书
\setCJKmainfont{KaiTi} % 设置中文字体
\setmainfont{Times New Roman} % 设置英文字体

% 页面布局设置
\RequirePackage{geometry}
\geometry{a4paper,left = 1cm,right = 1cm,top = 1.5cm,bottom= 1.5cm}

% 颜色设置
\RequirePackage{xcolor}
\definecolor{lightgray}{gray}{0.8} % 定义浅灰色
\definecolor{NJUpurple}{RGB}{111,16,110} % 定义南大紫
\colorlet{ThemeColor}{NJUpurple} % 设置主题颜色

% TikZ 图形绘制
\RequirePackage{tikz}
\usetikzlibrary{calc}

% 全局字体大小与行距
\AtBeginDocument{%
    \fontsize{14}{14}\selectfont
}

% 页眉
\AtBeginDocument{%
    \begin{tikzpicture}[remember picture, overlay]
        % 色带
        \fill[color=ThemeColor] (current page.north west) rectangle ($(current page.north east) + (0,-1cm)$);
        
        % 原点位置
        \coordinate (spawn) at ($(current page.north west) + (2.5cm,-1cm)$);
        
        % 三角形
        \fill[color=ThemeColor] 
            ($(spawn) + (-2cm,0.2cm)$) -- % 左顶点
            ($(spawn) + (2cm,0.2cm)$) -- % 右顶点
            ($(spawn) + (0,-0.5cm)$) -- % 下顶点
            cycle;
        
        % 文字
        \node[anchor=west, text=white, font=\bfseries\Huge] at ($(spawn) + (-2cm,0.5cm)$) {个人简历};
    \end{tikzpicture}
}

%姓名和logo
\AtBeginDocument{%
    \begin{minipage}[t]{0.5\textwidth}
        \hspace{-0.1cm}\textbf{\Huge \name}
        % 下划线
        \begin{tikzpicture}[remember picture, overlay,line width = 2pt]
            \coordinate (line start) at ($(current page.north west) + (0, -2.5cm)$);
            \coordinate (line end) at ($(line start) + (0.45\textwidth, 0)$); 
            \draw[color=ThemeColor] (line start) -- (line end);
            \fill[color=ThemeColor] (line end) circle (3pt);
        \end{tikzpicture}
    \end{minipage}%
    
    \begin{minipage}[t]{0.5\textwidth}
        \raggedleft
        \begin{tikzpicture}[remember picture, overlay]
            \node[
                inner sep=-1pt,
                fill=ThemeColor,
                xshift = 7.3cm,
                yshift = 1cm,
                rectangle,
                outer sep=0pt
            ]{
                \includegraphics[width=.5\linewidth]{figures/logo.png}
            };
            
        \end{tikzpicture}
    \end{minipage}
    
}

% 段落和列表格式设置
\setlength{\parindent}{0pt} % 段落首行不缩进
\setlength{\parskip}{6pt}   % 段落间距

% 列表格式设置
\RequirePackage{enumitem}
\setlist[itemize]{noitemsep, topsep=0pt} % 去除列表项间距

% 超链接设置
\RequirePackage{hyperref}
\hypersetup{
colorlinks=true,
linkcolor=black,
citecolor=black,
urlcolor=black,
anchorcolor=black
}

\renewcommand{\section}[1]{%
    \noindent
    \begin{tikzpicture}[
        remember picture, 
        overlay,
        title style/.style={
            anchor=west,
            font=\Large\bfseries,
            inner sep=0pt
        }
    ]
        \node[title style] (section_title) {#1};

        % 分割线
        \draw[
            ThemeColor,
            line width=2pt,
            shorten >=-1pt  
        ] ($(section_title.south west)- (0.4cm, 0.2cm)$) 
          -- ($(current page.east |- section_title.south west) - (0.6cm, 0.2cm)$);

        \fill[ThemeColor] ($(section_title.south west) +(-0.2cm, -0.2cm)$)
            -- ($(section_title.south east) +(0.7cm, -0.2cm)$) 
            -- ($(section_title.north east) +(0.4cm, 0.2cm)$)
            -- ($(section_title.north west) +(0.1cm, 0.2cm)$); 

        \node[title style, text=white, xshift=0.2cm] (section_title) {#1};

        \draw[ThemeColor, line width=2pt] ($(section_title.south west) + (-0.6cm, -0.2cm)$) -- ($(section_title.south west|- current page.south west) + (-0.6cm, 0)$);

        \draw[ThemeColor, line width=2pt] ($(current page.east |- section_title.south west) - (0.6cm, 0.2cm)$) -- ($(current page.south east) - (0.6cm, 0)$);
    \end{tikzpicture}
    \vspace{10pt}
}

% 一个用的比较多的环境
\newcommand{\tricol}[3]{%
    \noindent % 取消段落缩进
    \begin{minipage}[t]{0.33\textwidth} 
        \raggedright #1
    \end{minipage}%
    \hfill 
    \begin{minipage}[t]{0.33\textwidth} 
        \center #2
    \end{minipage}%
    \hfill 
    \begin{minipage}[t]{0.33\textwidth} 
        \raggedleft #3
    \end{minipage}
    \par 
}

% 定义列表项格式
\newcommand{\resumeitem}[2]{%
    \begin{itemize}
        \item \textbf{#1} \hfill \textbf{#2}
    \end{itemize}
}

% 页脚

\AtBeginDocument{%
    \pagestyle{empty}
    \begin{tikzpicture}[remember picture, overlay]
        \node[
            anchor=south,
            inner sep=-2pt,
            yshift=-0.7cm,
            fill=ThemeColor,
            rectangle,
            outer sep=0pt
        ] at (current page.south) {
            \includegraphics[width=\textwidth]{figures/figure.png}
        };
        
        % 色带
        \fill[color=ThemeColor] (current page.south east) rectangle ($(current page.south west) + (0,0.5cm)$);
        
        
    \end{tikzpicture}
}
