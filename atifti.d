// test Alias Template IFTI
module test.atifti;

struct TempT(T)
{

}

alias AliasT(U) = TempT!U;
alias AliasPT(U) = TempT!(U*);

void fooAliasT(U)(AliasT!U v)
{
    static assert(is(U == float));
    static assert(is(typeof(v) == TempT!(float)));
}

void fooAliasPT(U)(AliasPT!(U) v)
{
    static assert(is(U == float));
    static assert(is(typeof(v) == TempT!(float*)));
}

void pfooAliasPT(U)(AliasPT!(U*) v)
{
    static assert(is(U == float));
    static assert(is(typeof(v) == TempT!(float**)));
}

struct TempVar(T...)
{

}

alias AliasVar(T, U...) = TempVar!(T, U);

void fooAliasVar(U...)(AliasVar!U v)
{
    static assert(is(U[0] == float));
    static assert(is(U[1] == int));
    static assert(is(U[2] == char));
    static assert(is(U[3] == string));
}

struct TempDiverse(X, Y, size_t Z, alias W)
{
}

alias AliasDiverse(P, Q, alias R, size_t S) = TempDiverse!(Q, P, S, R);

void fooAliasDiverse(A, B, alias C, size_t D)(AliasDiverse!(B, A, C, D) v)
{
    static assert(is(A == string));
    static assert(is(B == char));
    static assert(C == 1);
    static assert(D == 12);
    static assert(is(typeof(v) == TempDiverse!(string, char, 12, 1)));
}

struct Matrix(U, size_t M, size_t N)
{

}

alias Vector(U, size_t N) = Matrix!(U, N, 1);
alias Vector3(U) = Vector!(U, 3);

void normalize(U, size_t N)(ref Vector!(U, N) v)
{
}

Vector3!U cross(U)(Vector3!U a, Vector3!U b)
{
    return Vector3!U.init;
}

import somemod;

void main()
{
    fooSomeAliasTv(SomeAliasT!(float, char)());
    fooSomeAliasT(SomeAliasT!float());
    fooAliasT(AliasT!float());
    fooAliasPT(AliasPT!(float)());
    pfooAliasPT(AliasPT!(float*)());
    fooAliasVar(AliasVar!(float, int, char, string)());
    fooAliasDiverse(AliasDiverse!(char, string, 1, 12)());

    static assert(is(Vector3!float == Vector3!U, U)); // !!! 

    Vector!(float, 10) v;
    normalize(v);
    auto vv = cross(Vector3!float(), Vector3!float());

    import std.traits;

    static assert(is(typeof(vv) == Vector3!float));
    static assert(isInstanceOf!(Vector3, Vector3!float));

    static assert(isInstanceOf!(SomeAlias2, SomeAlias2!float));

    void fooSomeAlias2(U)(SomeAlias2!U v)
    {

    }

    fooSomeAlias2(SomeAlias2!char());

    import std.regex;

    void fooRegex(U)(Regex!U)
    {

    }

    fooRegex(Regex!char());
    static assert(isInstanceOf!(Regex, Regex!char));

    {
        struct TestType(T, Q)
        {
        }

        alias TestAliasA(A, B) = TestType!(A, B);
        alias TestAlias(T, Q) = TestAliasA!(Q, T);
        void test(X, Y)(TestAliasA!(X, Y) v)
        {
        }

        test(TestAlias!(float, char)());
    }
}
