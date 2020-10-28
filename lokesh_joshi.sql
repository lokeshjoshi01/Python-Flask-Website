-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2020 at 05:04 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lokesh joshi`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `Sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `phone` int(50) NOT NULL,
  `massage` varchar(5000) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`Sno`, `name`, `phone`, `massage`, `date`, `email`) VALUES
(0, 'Lokesh Joshi', 2147483647, 'gg', '2020-10-23 12:08:29', 'gogodero@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `Sno` int(50) NOT NULL,
  `Title` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `Content` varchar(5000) NOT NULL,
  `tagline` varchar(25) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `img_file` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`Sno`, `Title`, `slug`, `Content`, `tagline`, `Date`, `img_file`) VALUES
(1, 'julia programming language', 'first-post', 'Scientific computing has traditionally required the highest performance, yet domain experts have largely moved to slower dynamic languages for daily work. We believe there are many good reasons to prefer dynamic languages for these applications, and we do not expect their use to diminish. Fortunately, modern language design and compiler techniques make it possible to mostly eliminate the performance trade-off and provide a single environment productive enough for prototyping and efficient enough for deploying performance-intensive applications. The Julia programming language fills this role: it is a flexible dynamic language, appropriate for scientific and numerical computing, with performance comparable to traditional statically-typed languages.\r\n\r\nBecause Julia\'s compiler is different from the interpreters used for languages like Python or R, you may find that Julia\'s performance is unintuitive at first. If you find that something is slow, we highly recommend reading through the Performance Tips section before trying anything else. Once you understand how Julia works, it\'s easy to write code that\'s nearly as fast as C.\r\n\r\nJulia features optional typing, multiple dispatch, and good performance, achieved using type inference and just-in-time (JIT) compilation, implemented using LLVM. It is multi-paradigm, combining features of imperative, functional, and object-oriented programming. Julia provides ease and expressiveness for high-level numerical computing, in the same way as languages such as R, MATLAB, and Python, but also supports general programming. To achieve this, Julia builds upon the lineage of mathematical programming languages, but also borrows much from popular dynamic languages, including Lisp, Perl, Python, Lua, and Ruby.\r\n\r\nThe most significant departures of Julia from typical dynamic languages are:\r\n\r\nThe core language imposes very little; Julia Base and the standard library are written in Julia itself, including primitive operations like integer arithmetic\r\nA rich language of types for constructing and describing objects, that can also optionally be used to make type declarations\r\nThe ability to define function behavior across many combinations of argument types via multiple dispatch\r\nAutomatic generation of efficient, specialized code for different argument types\r\nGood performance, approaching that of statically-compiled languages like C\r\nAlthough one sometimes speaks of dynamic languages as being \"typeless\", they are definitely not: every object, whether primitive or user-defined, has a type. The lack of type declarations in most dynamic languages, however, means that one cannot instruct the compiler about the types of values, and often cannot explicitly talk about types at all. In static languages, on the other hand, while one can – and usually must – annotate types for the compiler, types exist only at compile time and cannot be manipulated or expressed at run time. In Julia, types are themselves run-time objects, and can also be used to convey information to the compiler.\r\n\r\nWhile the casual programmer need not explicitly use types or multiple dispatch, they are the core unifying features of Julia: functions are defined on different combinations of argument types, and applied by dispatching to the most specific matching definition. This model is a good fit for mathematical programming, where it is unnatural for the first argument to \"own\" an operation as in traditional object-oriented dispatch. Operators are just functions with special notation – to extend addition to new user-defined data types, you define new methods for the + function. Existing code then seamlessly applies to the new data types.\r\n\r\nPartly because of run-time type inference (augmented by optional type annotations), and partly because of a strong focus on performance from the inception of the project, Julia\'s computational efficiency exceeds that of other dynamic languages, and even rivals that of statically-compiled languages. For large scale numerical problems, speed always has been, continues to be, and probably always will be crucial: the amount of data being processed has easily kept pace with Moore\'s Law over the past decades.\r\n\r\nJulia aims to create an unprecedented combination of ease-of-use, power, and efficiency in a single language. In addition to the above, some advantages of Julia over comparable systems include:\r\n\r\nFree and open source (MIT licensed)\r\nUser-defined types are as fast and compact as built-ins\r\nNo need to vectorize code for performance; devectorized code is fast\r\nDesigned for parallelism and distributed computation\r\nLightweight \"green\" threading (coroutines)\r\nUnobtrusive yet powerful type system\r\nElegant and extensible conversions and promotions for numeric and other types\r\nEfficient support for Unicode, including but not limited to UTF-8\r\nCall C functions directly (no wrappers or special APIs needed)\r\nPowerful shell-like capabilities for managing other processes\r\nLisp-like macros and other m', 'Wrriten By Lokesh Joshi', '2020-10-23 11:54:44', 'img/home-bg.jpg'),
(2, 'Julia vs. Python: Which is best for data science?', 'second-post', 'Here are some of the ways Julia implements those aspirations:\r\n\r\n\r\nJulia is compiled, not interpreted. For faster runtime performance, Julia is just-in-time (JIT) compiled using the LLVM compiler framework. At its best, Julia can approach or match the speed of C.\r\nJulia is interactive. Julia includes a REPL (read-eval-print loop), or interactive command line, similar to what Python offers. Quick one-off scripts and commands can be punched right in.\r\nJulia has a straightforward syntax. Julia’s syntax is similar to Python’s—terse, but also expressive and powerful.\r\nJulia combines the benefits of dynamic typing and static typing. You can specify types for variables, like “unsigned 32-bit integer.” But you can also create hierarchies of types to allow general cases for handling variables of specific types—for instance, to write a function that accepts integers without specifying the length or signing of the integer. You can even do without typing entirely if it isn’t needed in a particular context.\r\nJulia can call Python, C, and Fortran libraries. Julia can interface directly with external libraries written in C and Fortran. It’s also possible to interface with Python code by way of the PyCall library, and even share data between Python and Julia.\r\nJulia supports metaprogramming. Julia programs can generate other Julia programs, and even modify their own code, in a way that is reminiscent of languages like Lisp.\r\nJulia has a full-featured debugger. Julia 1.1 introduced a debugging suite, which executes code in a local REPL and allows you to step through the results, inspect variables, and add breakpoints in code. You can even perform fine-grained tasks like stepping through a function generated by code.\r\nRelated video: How Python makes programming easier\r\nPerfect for IT, Python simplifies many kinds of work, from system automation to working in cutting-edge field\r\n\r\nJulia vs. Python: Julia language advantages\r\nJulia was designed from the start for scientific and numerical computation. Thus it’s no surprise that Julia has many features advantageous for such use cases:\r\n\r\nJulia is fast. Julia’s JIT compilation and type declarations mean it can routinely beat “pure,” unoptimized Python by orders of magnitude. Python can be made faster by way of external libraries, third-party JIT compilers (PyPy), and optimizations with tools like Cython, but Julia is designed to be faster right out of the gate.\r\nJulia has a math-friendly syntax. A major target audience for Julia is users of scientific computing languages and environments like Matlab, R, Mathematica, and Octave. Julia’s syntax for math operations looks more like the way math formulas are written outside of the computing world, making it easier for non-programmers to pick up on.\r\nJulia has automatic memory management. Like Python, Julia doesn’t burden the user with the details of allocating and freeing memory, and it provides some measure of manual control over garbage collection. The idea is that if you switch to Julia, you don’t lose one of Python’s common conveniences.\r\nJulia offers superior parallelism. Math and scientific computing thrive when you can make use of the full resources available on a given machine, especially multiple cores. Both Python and Julia can run operations in parallel. However, Python’s methods for parallelizing operations often require data to be serialized and deserialized between threads or nodes, while Julia’s parallelization is more refined. Further, Julia’s parallelization syntax is less top-heavy than Python’s, lowering the threshold to its use.\r\nJulia is developing its own native machine learning libraries. Flux is a machine learning library for Julia that has many existing model patterns for common use cases. Since it\'s written entirely in Julia, it can be modified as needed by the user, and it uses Julia\'s native just-in-time compilation to optimize projects from inside out. ', 'Wrriten By Lokesh Joshi', '2020-10-23 11:57:22', 'img/about-bg.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`Sno`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`Sno`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
