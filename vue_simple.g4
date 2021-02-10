grammar vue_simple;

program: bindings methodDefinitions createdMethod topLevelProperties computedProperties;

topLevelProperties: thisIdentifier*;
methodDefinitions: methodDefinition*; 
createdMethod: methodDefinition;
computedProperties: (methodDefinitionIdentifier reads writes calls)*;

methodDefinition: methodDefinitionIdentifier methodArgs reads writes calls;

methodArgs: NAME_IDENTIFIER*;
reads: accessedVariable*;
writes: accessedVariable*;
calls: calledMethod*;

calledMethod: calledMethodIdentifier '(' calledArgs ')';
accessedVariable: identifier;
calledArgs: (calledMethod | accessedVariable)*;

bindings: binding*;
binding: tag bindingSource+;
bindingSource: (accessedVariable | calledMethod) (EVENT_BINDING | ONE_WAY_BINDING)
              | accessedVariable TWO_WAY_BINDING;

tag: name tagId loc;
tagId: LINE '_' COLUMN '_' LINE '_' COLUMN;
name: UNICODE | identifier;
loc: start end;
start: LINE COLUMN;
end: LINE COLUMN;

calledMethodIdentifier: methodDefinitionIdentifier | id* NAME_IDENTIFIER;

methodDefinitionIdentifier: THIS NAME_IDENTIFIER;
thisIdentifier: THIS identifier;
identifier: NAME_IDENTIFIER id*;


id: NUMERIC_INDEX | GENERIC_INDEX | NAME_IDENTIFIER;

//terminals, tokens
LINE: [0-9]+;
COLUMN: [0-9]+;

EVENT_BINDING: 'event';
TWO_WAY_BINDING: 'two-way';
ONE_WAY_BINDING: 'one-way';

GENERIC_INDEX: 'i' | 'j' | 'k' | 'l' | 'm' | 'n';
THIS: 'this';

NUMERIC_INDEX: [0-9]+;
NAME_IDENTIFIER:  JS_IDENTIFIER;
JS_IDENTIFIER:  (UNICODE | '$' | '_') (UNICODE | '$' | '_' | [0-9])*;
UNICODE: [\u0000-\uFFFF];