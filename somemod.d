module somemod;
static import somemod2;

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

public alias SomeAlias2(U) = somemod2.SomeTemp2!U;
