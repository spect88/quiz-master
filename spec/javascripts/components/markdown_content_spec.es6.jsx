describe('MarkdownContent component', () => {
  let md;
  let component, domNode;

  it('displays markdown content as HTML', () => {
    md = '**Hello** _world_!';

    render();

    expect(domNode.textContent.trim()).toEqual('Hello world!');
    expect(selectTextContent('strong', domNode)).toEqual('Hello');
    expect(selectTextContent('em', domNode)).toEqual('world');
  });

  it('escapes HTML in the content', () => {
    md = '<img src=x onerror=alert(1)> **hi there**';

    render();

    expect(domNode.textContent.trim()).toEqual(md.replace(/\*/g, ''));
  });

  function render() {
    component = TestUtils.renderIntoDocument(<MarkdownContent content={md}/>);
    domNode = ReactDOM.findDOMNode(component);
  }
});
