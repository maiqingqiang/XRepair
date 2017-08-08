import React, {PureComponent} from 'react'
import './HeadTitle.less'

export default class HeadTitle extends PureComponent {
    render() {

        const {title, subTitle} = this.props;
        return (
            <div id="general-index">
                <div className="am-hd">
                    <h1 className="am-title">
                        <span>{title}</span>
                    </h1>
                    <h2 className="am-subtitle">
                        <span>{subTitle}</span>
                    </h2>
                </div>
            </div>
        );
    }
}