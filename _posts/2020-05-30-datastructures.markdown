---
layout: post
title:  "C++ Data Structures Overview"
date:   2020-5-30
tags: [C++, algorithms, data structures]
description: Here's a quick summary of the more famous data structures present in C++, access times and intended usage
---

I'd like to start off this post by going through most of the data structures present in C++, as a sort of introduction into them. 

This article was written in 2021, with C++14 in mind, there are no major changes to how data structures work but there might be very minor changes to some syntax.

One of the great things about C++ is that is has, in many cases, direct correnpondence between C++ concepts and equivalent ones in machine language (what the compiler outputs), so when we're talking about data structures in many situations we can refer to direct memory implementations in machine language. There is a neat website called https://godbolt.org/ that lets you compare code with compiler output. This is pretty handy sometimes in trying to optimise code. 
<!--- <iframe width="800px" height="300px" src="https://godbolt.org/e#g:!((g:!((g:!((h:codeEditor,i:(filename:'1',fontScale:14,[comment]:fontUsePx:'0',j:1,lang:c%2B%2B,source:'//+Type+your+code+here,+or+load+an+example.%0Aint+square(int+num)+%7B%0A++++return+num+*+num%3B%0A%7D'),l:'5',n:'0',o:'C%2B%2B+source+%231',t:'0')),k:50,l:'4',n:'0',o:'',s:0,t:'0'),(g:!((h:compiler,i:(compiler:g121,filters:(b:'0',binary:'1',commentOnly:'0',demangle:'0',directives:'0',execute:'1',intel:'0',libraryCode:'0',trim:'1'),flagsViewOpen:'1',fontScale:14,fontUsePx:'0',j:1,lang:c%2B%2B,libs:!(),options:'',selection:(endColumn:12,endLineNumber:8,positionColumn:12,positionLineNumber:8,selectionStartColumn:12,selectionStartLineNumber:8,startColumn:12,startLineNumber:8),source:1,tree:'1'),l:'5',n:'0',o:'x86-64+gcc+12.1+(C%2B%2B,+Editor+%231,+Compiler+%231)',t:'0')),k:50,l:'4',n:'0',o:'',s:0,t:'0')),l:'2',n:'0',o:'',t:'0')),version:4"></iframe> -->

 _\- here's a good example of a simple from a relatively simple function and what it looks like in machine language. C++ ends up being picked a lot for applications that require both Object Oriented Design and good optimisation venues because of this near direct correspondence._

In this article we will largely be talking about the data structures that come with the standard (std) library but also some structures that aren't. 

_Why am I writing about concrete implementations instead of just generic data structures_?

Because this is largely focused in C++, and although most of the knowledge about arrays, sets, hash maps etc applies we also wish to take advantage of pre-existing C++ or C standard implementations, making our lifes just a bit easier.

# The Vector

The most commonly used by far, the vector is an ordered container of items of the same type, stored contiguously in memory (at least the virtual memory). The std library already has a vector inside of it and it will likely be the most used data structure in C++. Since C++11 most of the standard library data structures support a pointer (memory address) to their first item as well as one after its end.

```
std::vector<int> myVector;
```
_\-Creating a vector called myVector of integers_

With the standard library we also get the following standard functions,

operation | description | complexity
---|---|---
operator[] | The standard operator for accessing the nth element of the vector, usually seen abreviated in code by just [size_type]. Because it knows the memory size of each of its elements it's fairly fast to go the corresponding memory slot. Be careful however, as this operator does not check if it is allowed to go the memory area in question. It is undefined behaviour if it does (in release code). So only use it if you know the memory position in question is within the boundaries of your data structure. | Constant
at() | A safer version of operator[] the at checks if the position in question lies within the size of the vector, throwing an exception if it's breaching it. Might be useful in situations where you expect a vector to be of a certain size but need to check regardless. | Constant
size() | Pretty self explanatory, it returns the number of elements currently in the vector (not to be confused with the vector capacity) | Constant
reserve() | Makes room for elements so that assignment operations are done fairly fast to make sure the vector continues to obey the contiguously memory requirement. If it's above the vector's capacity it will need to reserve more memory and if needed it will move elements to a new location. Internally the compiler uses a heuristic to more or less determine if it is likely that it will need in future to move all the elements and it's fairly good for most cases so don't worry too much about it unless your code requires that level of optimisation. | At worst, it has vector size linear complexity
capacity() | Returns the allocated memory for the vector in question, via reserve. This value will go up if more items are added regardless. | Constant complexity
push_back() | Adds an element at the end of the vector, by far the quickest insert. To garantee top speed with it, make sure you're working within capacity. | Constant complexity.
insert() | Inserts an element to wherever the iterator points. Mind you this is a more expensive operation as it requires every single other element after to be shifted in memory to maintain the contiguous memory property of the vector. | Linear complexity, to different degrees depending on what's required.
erase() | Works in similar fashion to the insert but to remove items from the vector. | Linear complexity, but without any risk of going above capacity.

You can find the full specification here:

https://www.cplusplus.com/reference/vector/vector/

# The Array

# The Lists

# Stack/Queue

# Trees (Tree, Binary Tree, Binary Search Tree, Red-Black Tree, etc.)

# Heap

# The Maps (unordered etc)

TODO: this is really important - understand all of the different collision mitigation mechanisms, understand what amortized constant-time means)

# Directed/Undirected/Weighted Graphs

# Trie (pronounced "tree")

# Linked Hash Map

 (this is very specific)

# The Octree

# Graphs (directed undirected)
    