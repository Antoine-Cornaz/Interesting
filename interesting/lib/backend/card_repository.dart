final class CardRepository {
  List<List<String>> get allCards => [
    _cardsInstruction,
    _cardsArithmetic,
    _cardsPreAlgebra,
    _cardsElementaryAlgebra,
    _cardsSystemEquation,
    _cardsIntermediateAlgebra,
    _cardsPreCalculus,
    _cardsCalculus,
    _cardsDifferentialEqu,
  ];

  List<String> get cardInstruction => _cardsInstruction;
  List<String> get cardsArithmetic => _cardsArithmetic;
  List<String> get cardsPreAlgebra => _cardsPreAlgebra;
  List<String> get cardsElementaryAlgebra => _cardsElementaryAlgebra;
  List<String> get cardsSystemEquation => _cardsSystemEquation;
  List<String> get cardsIntermediateAlgebra => _cardsIntermediateAlgebra;
  List<String> get cardsPreCalculus => _cardsPreCalculus;
  List<String> get cardsCalculus => _cardsCalculus;
  List<String> get cardsDifferentialEqu => _cardsDifferentialEqu;


  final List<String> _cardsInstruction = [
    '''
You’ll see a series of math problems. No need to solve them. 
Just answer: Can you solve this one?

Swipe right for Yes, left for No, up for Maybe.
Ready? Swipe anywhere to start.

Prefer tapping? Use the buttons below.
''',
  ];


  final List<String> _cardsArithmetic = [
    r"5+8=?",
    r"12-7=?",
    r"5 \times 4 = ?",
    r"\frac{12}{4}=?",
    r"5.2 + 12.5 = ?",
    r"40\% = ?",
  ];


  final List<String> _cardsPreAlgebra = [
    r"3^5",
    r'\sqrt[3]{27}',
    r"\frac{3}{4} = ...\%",
    r"|-5|",
    r"\frac{2}{3} + \frac{1}{4}",
    r"7 = x \cdot 28",
  ];


  final List<String> _cardsElementaryAlgebra = [
    r'5x+3x = 2x - 7',
    r'x-8 < 2x',
    r'x(2x+3)',
    r'(x+2)(x-3)',
    r'x^2 - 9 = 0',
    r'\frac{x}{3} = 5',
  ];


  final List<String> _cardsSystemEquation = [
    r"""\begin{cases}
    3x + 2y = 10 \\
    4x + 2y = 13
    \end{cases}
  """,
    r"""\begin{bmatrix}
    3 & 2 \\
    4 & 2
    \end{bmatrix}
    \begin{bmatrix}
    x \\
    y
    \end{bmatrix}
    =
    \begin{bmatrix}
    10 \\
    13
    \end{bmatrix}
  """,
    r"""\begin{cases}
    y = 2x + 1 \\
    y = -x + 4
    \end{cases}
  """,
    r"""\begin{cases}
    x + y + z = 6 \\
    2x - y + z = 3 \\
    x + z = 4
    \end{cases}
  """,
    r"""\begin{aligned}
    y &= x^2 \\
    y &= x+2
    \end{aligned}
  """,
    r"""\begin{cases}
    5x - 2y = 16 \\
    2x + 3y = 1
    \end{cases}
  """,
  ];


  final List<String> _cardsIntermediateAlgebra = [
    r"""\begin{aligned}
    3x^2 + 8x &= 2x - 5 \\
    3x^2 + 6x + 5 &= 0
    \end{aligned}
  """,
    r"(5+3i)(2-4i)",
    r"e^{\frac{1}{2} \ln (4x^2)}",
    r"\log_2(x) + \log_2(x-2) = 3",
    r"\frac{x^2-4}{x^2-x-2}",
    r"|2x - 1| \le 5",
  ];


  final List<String> _cardsPreCalculus = [
    r"x^2=1+i",
    r"(\cos(x)+1)^2 + \sin^2(x) = 1.5",
    r"\sum_{j=1}^{\infty} \frac{1}{2^j}",
    r"\lim_{x\to 2} \frac{x^2-4}{x-2}",
    r"""\begin{aligned}
    f(x) &= 2x+1 \\
    g(x) &= x^2 \\
    (f \circ g)(x) &= ?
    \end{aligned}
  """,
    r"(x,y) = (-1, \sqrt{3}) \rightarrow (r, \theta)",
  ];


  final List<String> _cardsCalculus = [
    r"\lim_{x\to 0} \frac{\sin(2x)}{x}",
    r"\frac{d}{dx}(\cos(x)) = ?",
    r"\int_{-\infty}^0 e^x dx",
    r"\frac{d}{dx} (x^3 - 4x + 2)",
    r"\int (3x^2 + \sin(x)) dx",
    r"""\begin{aligned}
    y &= x^3 \\
    \frac{dy}{dx}\bigg|_{x=2} &= ?
    \end{aligned}
  """,
  ];


  final List<String> _cardsDifferentialEqu = [
    r"f'(x)=2f''(x)",
    r"\frac{d^2 y}{dx^2} + 5x \left(\frac{dy}{dx}\right)^3 = 3\cos(x)",
    r"""\begin{cases}
    \frac{dx}{dt} = 6x-y \\ \\
    \frac{dy}{dt} = 5x + 4y
    \end{cases}
  """,
    r"y' + 2y = 0",
    r"y'' - 3y' + 2y = 0",
    r"\frac{dy}{dx} = \frac{x^2}{y}",
  ];
}
