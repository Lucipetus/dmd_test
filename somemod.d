module test.somemod;

private struct SomeTempT(U...)
{

}

public alias SomeAliasT(U...) = SomeTempT!(U);

public void fooSomeAliasTv(U...)(SomeAliasT!U v)
{
    static assert(is(U[0] == float));
    static assert(is(U[1] == char));
}

public void fooSomeAliasT(U)(SomeAliasT!U v)
{
    static assert(is(U == float));
}
