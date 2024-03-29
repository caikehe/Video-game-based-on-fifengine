/***************************************************************************
 *   Copyright (C) 2005-2013 by the FIFE team                              *
 *   http://www.fifengine.net                                              *
 *   This file is part of FIFE.                                            *
 *                                                                         *
 *   FIFE is free software; you can redistribute it and/or                 *
 *   modify it under the terms of the GNU Lesser General Public            *
 *   License as published by the Free Software Foundation; either          *
 *   version 2.1 of the License, or (at your option) any later version.    *
 *                                                                         *
 *   This library is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
 *   Lesser General Public License for more details.                       *
 *                                                                         *
 *   You should have received a copy of the GNU Lesser General Public      *
 *   License along with this library; if not, write to the                 *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA          *
 ***************************************************************************/

%module fifechan
%{
#include <fifechan.hpp>
%}

namespace fcn {
	class Font;
	class Image;
	class ActionListener;
	class MouseListener;
	class KeyListener;

	%nodefaultctor;
	class Graphics {
	public:
		enum Alignment {
			Left = 0,
			Center,
			Right
		};
	};
	%clearnodefaultctor;
	
	class Color {
	public:
		Color();
		Color(int32_t color);
		Color(int32_t r, int32_t g, int32_t b, int32_t a = 255);
		Color operator+(const Color& color) const;
		Color operator-(const Color& color) const;
		Color operator*(float value) const;
		bool operator==(const Color& color) const;
		bool operator!=(const Color& color) const;
		int32_t r;
		int32_t g;
		int32_t b;
		int32_t a;
	};

	class Widget {
	public:
/* 		Widget(); */
/* 		virtual ~Widget(); */
		virtual void setWidth(int32_t width);
		virtual int32_t getWidth() const;
		virtual void setHeight(int32_t height);
		virtual int32_t getHeight() const;
		virtual void setSize(int32_t width, int32_t height);
		virtual void setX(int32_t x);
		virtual int32_t getX() const;
		virtual void setY(int32_t y);
		virtual int32_t getY() const;
		virtual void setPosition(int32_t x, int32_t y);
		virtual void setFrameSize(uint32_t frameSize);
		virtual uint32_t getFrameSize() const;
		virtual void setFocusable(bool focusable);
		virtual bool isFocusable() const;
		virtual bool isFocused() const;
		virtual void setEnabled(bool enabled);
		virtual bool isEnabled() const;
		virtual void setVisible(bool visible);
		virtual bool isVisible() const;
		virtual void setBaseColor(const Color& color);
		virtual const Color& getBaseColor() const;
		virtual void setForegroundColor(const Color& color);
		virtual const Color& getForegroundColor() const;
		virtual void setBackgroundColor(const Color& color);
		virtual const Color& getBackgroundColor() const;
		virtual void setSelectionColor(const Color& color);
		virtual const Color& getSelectionColor() const;
		virtual void requestFocus();
		virtual void requestMoveToTop();
		virtual void requestMoveToBottom();
		virtual void setActionEventId(const std::string& actionEventId);
		virtual const std::string& getActionEventId() const;
		virtual void getAbsolutePosition(int32_t& x, int32_t& y) const;
		Font *getFont() const;
		static void setGlobalFont(Font* font);
		virtual void setFont(Font* font);
		virtual bool isTabInEnabled() const;
		virtual void setTabInEnabled(bool enabled);
		virtual bool isTabOutEnabled() const;
		virtual void setTabOutEnabled(bool enabled);
		virtual void requestModalFocus();
		virtual void requestModalMouseInputFocus();
		virtual void releaseModalFocus();
		virtual void releaseModalMouseInputFocus();
		virtual bool isModalFocused() const;
		virtual bool isModalMouseInputFocused() const;
		virtual Widget *getWidgetAt(int32_t x, int32_t y);
		virtual void moveToTop(Widget* widget) { };
		virtual void moveToBottom(Widget* widget) { };
		virtual void focusNext() { };
		virtual void focusPrevious() { };
		virtual void addActionListener(ActionListener* actionListener);
		virtual void removeActionListener(ActionListener* actionListener);
		virtual void addMouseListener(MouseListener* actionListener);
		virtual void removeMouseListener(MouseListener* actionListener);
		virtual void addKeyListener(KeyListener* actionListener);
		virtual void removeKeyListener(KeyListener* actionListener);
		virtual void addWidgetListener(WidgetListener* widgetListener);
		virtual void removeWidgetListener(WidgetListener* widgetListener);
/* 	protected: */
		virtual void draw(Graphics* graphics) = 0;
	};
	
	%feature("notabstract") Container;
	class Container: public Widget {
	public:
		Container();
		virtual ~Container();
		virtual void setOpaque(bool opaque);
		virtual bool isOpaque() const;
		virtual void add(Widget* widget);
		virtual void add(Widget* widget, int32_t x, int32_t y);
		virtual void remove(Widget* widget);
		virtual void clear();
	};
	
	%feature("notabstract") CheckBox;
	class CheckBox: public Widget {
	public:
		CheckBox();
		virtual ~CheckBox();
		virtual bool isSelected() const;
		virtual void setSelected(bool marked);
		virtual const std::string &getCaption() const;
		virtual void setCaption(const std::string& caption);
		virtual void adjustSize();
	};

	
	%feature("notabstract") Button;
	class Button: public Widget {
	public:
		Button();
		Button(const std::string& caption);
		virtual void setCaption(const std::string& caption);
		virtual const std::string& getCaption() const;
		virtual void setAlignment(Graphics::Alignment alignment);
		virtual Graphics::Alignment getAlignment() const;
		virtual void adjustSize();
		/*virtual bool isPressed() const;*/
	};
		
	%feature("notabstract") ScrollArea;
	class ScrollArea: public Widget {
	public:
		ScrollArea();
		ScrollArea(Widget *content);
		ScrollArea(Widget *content,ScrollArea::ScrollPolicy hPolicy,ScrollArea::ScrollPolicy vPolicy);
		virtual ~ScrollArea();
		virtual void setContent(Widget* widget);
		virtual Widget* getContent();
		virtual void setHorizontalScrollPolicy(ScrollArea::ScrollPolicy hPolicy);
		virtual ScrollArea::ScrollPolicy getHorizontalScrollPolicy();
		virtual void setVerticalScrollPolicy(ScrollArea::ScrollPolicy vPolicy);
		virtual ScrollArea::ScrollPolicy getVerticalScrollPolicy();
		virtual void setScrollPolicy(ScrollArea::ScrollPolicy hPolicy, ScrollArea::ScrollPolicy vPolicy);
		virtual void setVerticalScrollAmount(int32_t vScroll);
		virtual int32_t getVerticalScrollAmount();
		virtual void setHorizontalScrollAmount(int32_t hScroll);
		virtual int32_t getHorizontalScrollAmount();
		virtual void setScrollAmount(int32_t hScroll, int32_t vScroll);
		virtual int32_t getHorizontalMaxScroll();
		virtual int32_t getVerticalMaxScroll();
		virtual void setScrollbarWidth(int32_t width);
		virtual int32_t getScrollbarWidth();
		virtual void setLeftButtonScrollAmount(int32_t amount);
		virtual void setRightButtonScrollAmount(int32_t amount);
		virtual void setUpButtonScrollAmount(int32_t amount);
		virtual void setDownButtonScrollAmount(int32_t amount);
		virtual int32_t getLeftButtonScrollAmount();
		virtual int32_t getRightButtonScrollAmount();
		virtual int32_t getUpButtonScrollAmount();
		virtual int32_t getDownButtonScrollAmount();
		enum ScrollPolicy
		{
			ShowAlways,
			ShowNever,
			ShowAuto
		};
	};
	

	%feature("director") ListModel;
	class ListModel
	{
	public:
		virtual ~ListModel() { }
		virtual int32_t getNumberOfElements() = 0;
		virtual std::string getElementAt(int32_t i) = 0;
	};

	%feature("notabstract") ListBox;
	class ListBox: public Widget {
	public:
		ListBox();
		ListBox(ListModel *listModel);
		virtual ~ListBox() { }
		virtual int32_t getSelected();
		virtual void setSelected(int32_t selected);
		virtual void setListModel(ListModel *listModel);
		virtual ListModel *getListModel();
		virtual void adjustSize();
		virtual bool isWrappingEnabled();
		virtual void setWrappingEnabled(bool wrapping);
	};

	%feature("notabstract") DropDown;
	class DropDown: public Widget {
	public:
		DropDown(ListModel *listModel = NULL,
		         ScrollArea *scrollArea = NULL,
		         ListBox *listBox = NULL);
		virtual ~DropDown();
		virtual int32_t getSelected();
		virtual void setSelected(int32_t selected);
		virtual void setListModel(ListModel *listModel);
		virtual ListModel *getListModel();
		virtual void adjustHeight();
		virtual void setBaseColor(const Color& color);
		virtual const Color& getBaseColor() const;
		virtual void setForegroundColor(const Color& color);
		virtual const Color& getForegroundColor() const;
		virtual void setBackgroundColor(const Color& color);
		virtual const Color& getBackgroundColor() const;
		virtual void setSelectionColor(const Color& color);
		virtual const Color& getSelectionColor() const;
	};

	%feature("notabstract") RadioButton;
	class RadioButton: public Widget {
	public:
		RadioButton();
		RadioButton(const std::string &caption,
					const std::string &group,
					bool marked=false);
		virtual ~RadioButton();
		virtual bool isSelected() const;
		virtual void setSelected(bool marked);
		virtual const std::string &getCaption() const;
		virtual void setCaption(const std::string caption);
		virtual void setGroup(const std::string &group);
		virtual const std::string &getGroup() const;
		virtual void adjustSize();
	};

	%feature("notabstract") Slider;
	class Slider: public Widget {
	public:
		Slider(double scaleEnd = 1.0);
		Slider(double scaleStart, double scaleEnd);
		virtual ~Slider() { }
		virtual void setScale(double scaleStart, double scaleEnd);
		virtual double getScaleStart() const;
		virtual void setScaleStart(double scaleStart);
		virtual double getScaleEnd() const;
		virtual void setScaleEnd(double scaleEnd);
		virtual double getValue() const;
		virtual void setValue(double value);
		virtual void setMarkerLength(int32_t length);
		virtual int32_t getMarkerLength() const;
		virtual void setOrientation(Slider::Orientation orientation);
		virtual Slider::Orientation getOrientation() const;
		virtual void setStepLength(double length);
		virtual double getStepLength() const;
		enum Orientation
		{
			Horizontal = 0,
			Vertical
		};
	};

	%feature("notabstract") Window;
	class Window: public Container {
	public:
		Window();
		Window(const std::string& caption);
		virtual ~Window();
		virtual void setCaption(const std::string& caption);
		virtual const std::string& getCaption() const;
		virtual void setAlignment(Graphics::Alignment alignment);
		virtual Graphics::Alignment getAlignment() const;
		virtual void setPadding(uint32_t padding);
		virtual uint32_t getPadding() const;
		virtual void setTitleBarHeight(uint32_t height);
		virtual uint32_t getTitleBarHeight();
		virtual void setMovable(bool movable);
		virtual bool isMovable() const;
		virtual void setOpaque(bool opaque);
		virtual bool isOpaque();
		virtual void resizeToContent();
	};


	%feature("notabstract") TextBox;
	class TextBox: public Widget {
	public:
		TextBox();
		TextBox(const std::string& text);
		virtual void setText(const std::string& text);
		virtual std::string getText() const;
		virtual std::string getTextRow(int row) const;
		virtual void setTextRow(int row, const std::string& text);
		virtual int getNumberOfRows() const;
		virtual int getCaretPosition() const;
		virtual void setCaretPosition(int position);
		virtual int getCaretRow() const;
		virtual void setCaretRow(int row);
		virtual int getCaretColumn() const;
		virtual void setCaretColumn(int column);
		virtual void setCaretRowColumn(int row, int column);
		virtual void scrollToCaret();
		virtual bool isEditable() const;
		virtual void setEditable(bool editable);
		virtual void addRow(const std::string row);
		virtual bool isOpaque();
		virtual void setOpaque(bool opaque);
	};
	
	
	%feature("notabstract") TextField;
	class TextField: public Widget {
	public:
		TextField();
		TextField(const std::string& text);
		virtual ~TextField();
		virtual void setText(const std::string& text);
		virtual std::string getText() const;
		virtual void adjustSize();
		virtual void adjustHeight();
		virtual void setCaretPosition(uint32_t position);
		virtual uint32_t getCaretPosition() const;
    };
	

}



