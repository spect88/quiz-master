describe('InputField component', () => {
  let component, domNode;
  let model, onChangeSpy;

  beforeEach(() => {
    // this is an example model
    model = {
      leftHand: 'shield',
      leftHandError: null,
      rightHand: 'sword',
      rightHandError: null
    };
    onChangeSpy = jasmine.createSpy('onChange');

    component = TestUtils.renderIntoDocument(
      <InputField
        model={model}
        attribute="rightHand"
        id="input"
        label="Weapon Slot"
        onChange={onChangeSpy} />
    );
    domNode = ReactDOM.findDOMNode(component);
  });

  it('displays given label inside a <label> element', () => {
    expect(domNode.querySelector('label').textContent).toEqual('Weapon Slot');
  });

  it('sets appropriate input value', () => {
    expect(domNode.querySelector('input').value).toEqual('sword');
  });

  describe('when user changes input value', () => {
    beforeEach(() => {
      const input = domNode.querySelector('input');
      input.value = 'dagger';
      TestUtils.Simulate.change(input);
    });

    it('calls onChange callback with a modified model copy', () => {
      expect(onChangeSpy).toHaveBeenCalled();

      const changedModel = onChangeSpy.calls.first().args[0];
      expect(changedModel).not.toBe(model);

      expect(changedModel).toEqual({
        // other attributes are left as they were
        leftHand: 'shield',
        leftHandError: null,
        rightHand: 'dagger',
        rightHandError: null
      });
    })
  });

  describe('when attribute is valid', () => {
    it('doesn\'t add has-error class anywhere', () => {
      expect(domNode.className).not.toContain('has-error');
      expect(domNode.querySelector('.has-error')).toBeNull();
    });
  });

  describe('when attribute is invalid', () => {
    beforeEach(() => {
      model.rightHandError = 'Mage cannot wield a sword';
      component.setState({ just: 're-rendering' });
    });

    it('adds a has-error class to form-group container', () => {
      expect(domNode.className).toContain('has-error');
    });

    it('displays validation error message', () => {
      expect(domNode.querySelector('.text-danger').textContent)
        .toEqual(model.rightHandError);
    });

    describe('and user changes input value', () => {
      beforeEach(() => {
        const input = domNode.querySelector('input');
        TestUtils.Simulate.change(input);
      });

      it('validation error disappears from the changed model', () => {
        const changedModel = onChangeSpy.calls.first().args[0];
        expect(changedModel.rightHandError).not.toEqual(model.rightHandError);
        expect(changedModel.rightHandError).toBeNull();
      });
    });
  });
});
