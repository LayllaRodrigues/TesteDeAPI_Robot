*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net
Library          RequestsLibrary
Library          Collections

*** Variables ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/
${Book_15}    ID=15
...           Title=Book 15
...           PageCount=1500

*** Keywords ***

Conectar a minha API
    Create Session    fakeAPI    ${URL_API}

Requisitar todos os livros
    ${RESPOSTA}    GET Request    fakeAPI    Books
    Log            ${RESPOSTA.text}
    Set Test Variables    ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    GET Request    fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variables    ${RESPOSTA}

Conferir o status code
    [Arguments]    ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros 
    Length Should Be        ${RESPOSTA.json()}    ${QTDE_LIVROS}

Cadastrar um novo livro
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${RESPOSTA}    Post Request    fakeAPI    Books
    ...            data{}
    ...            header=${HEADERS
    Log            ${RESPOSTA.text}
    Set Test Variables    ${RESPOSTA}



