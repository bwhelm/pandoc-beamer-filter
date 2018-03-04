---
title: Pandoc Beamer Filter
author: bwhelm
---

This filter simplifies the creation of beamer slides from markdown. In particular, it will:

1. Replace `<...>` with `\\onslide<...>` when it starts a line; optionally `<...>` can be prepended by either `*` or `+`. For example:

        - <1> text on first slide only
        - <1-2> text on first and second slides only
        - +<3> text on third slide only

    will produce the following (beamer) LaTeX:

        \begin{frame}

        \begin{itemize}
        \tightlist
        \item
        \onslide<1> text on first slide only
        \item
        \onslide<1-2> text on first and second slides only
        \item
        \onslide+<3> text on third slide only
        \end{itemize}

        \end{frame}

