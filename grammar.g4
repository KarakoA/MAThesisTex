grammar js_simplified;

program: bindings methodDefinitions createdMethod topLevelProperties computedProperties;

topLevelProperties: thisIdentifier*;
methodDefinitions: methodDefinition*; 
createdMethod: methodDefinition;
computedProperties: (thisIdentifier reads writes calls)*;

methodDefinition: thisIdentifier methodArgs reads writes calls;

methodArgs: NAME_IDENTIFIER*;
reads: accesedVariable*;
writes: accesedVariable*;
calls: calledMethod*;

calledMethod: calledMethodIdentifier '(' calledArgs ')';
accesedVariable: identifier;
calledArgs: (calledMethod | accesedVariable)*;

bindings: binding*;
binding: tag accesedVariable | calledMethod BINDING_TYPE;

tag: name tagId loc;
tagId: LINE '_' COLUMN '_' LINE '_' COLUMN;
name: UNICODE | identifier;
loc: start end;
start: LINE COLUMN;
end: LINE COLUMN;

calledMethodIdentifier: THIS id* NAME_IDENTIFIER | id* NAME_IDENTIFIER;

thisIdentifier: THIS identifier;
identifier: NAME_IDENTIFIER id*;


id: NUMERIC_INDEX | GENERIC_INDEX | NAME_IDENTIFIER;

//terminals, tokens
LINE: [0-9]+;
COLUMN: [0-9]+;

BINDING_TYPE: 'event' | 'one-way' | 'two-way';
GENERIC_INDEX: 'i' | 'j' | 'k' | 'l' | 'm' | 'n';
THIS: 'this';

NUMERIC_INDEX: [0-9];
//valid js identifier
//https://developer.mozilla.org/en-US/docs/Glossary/Identifier
NAME_IDENTIFIER:  JS_IDENTIFIER;
JS_IDENTIFIER:  (UNICODE | '$' | '_') (UNICODE | '$' | '_' | [0-9])*;
UNICODE: [\u0000-\uFFFF];

// //TODO binary expr? vfor?