# Отчёт по фазз-тестированию MyToken

## 1. Отчёт 

В данном репозитории мы проводили фаззинг (fuzz-тестирование) для проверки свойств контракта **MyToken** с использованием внутренних (external) - команда `echidna test/MyTokenExternal.sol --contract MyTokenERC20ExternalHarness --config echidna-external.yaml` и внешних (internal) - команда `echidna test/MyTokenInternal.sol --contract CryticERC20InternalHarness  --config echidna-internal.yaml` свойств.

## 2. Изменения

### 2.1. Перечень внесённых изменений в код

1. **mint**  
   ```solidity
   function mint(address to, uint256 amount) public virtual {
       _mint(to, amount + 7);
   }
   ```
Добавляем +7 к amount, тем самым нарушаем корректность выпуска новых токенов.

Ожидалось, что _mint будет вызван с исходным amount, но фактически минтится на 7 больше.

2. **burnFrom**  
   ```solidity
   function burnFrom(address account, uint256 value)
    public
    virtual
    override(ERC20Burnable) {
    // Не уменьшаем allowance
    _burn(account, value);
    }
   ```
Здесь намеренно не учитываем и не уменьшаем allowance.

Любой может вызвать burnFrom без корректного разрешения, ломая логику, согласно которой при burnFrom надо проверять, что allowance[account][msg.sender] >= value.

3. **transfer**  
   ```solidity
   function transfer(address to, uint256 value)
    public
    virtual
    override(ERC20)
    returns (bool){
    address owner = _msgSender();
    if (to == address(0)) {
        to = address(1);
    }
    _transfer(owner, to, value);
    return true;
    }
    ```
Если указан нулевой адрес (0x0) для to, мы перенаправляем перевод на address(1) вместо revert.

Тем самым допускаем «псевдо-перевод» на запрещённый адрес, что ломает свойство корректной проверки to != address(0).

